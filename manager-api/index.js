const AWS = require("aws-sdk");
const sns = new AWS.SNS({ region: "ap-northeast-2" });
const sqs = new AWS.SQS({ region: "ap-northeast-2" });
const stockQueueUrl = process.env.STOCK_QUEUE_URL;
const attendanceQueueUrl = process.env.ATTENDANCE_QUEUE_URL;
const rewardQueueUrl = process.env.REWARD_QUEUE_URL;

exports.handler = async (event) => {
  try {
    const requestBody = JSON.parse(event.body);

    // Publish message to SNS topic
    const params = {
      Message: JSON.stringify(requestBody),
      TopicArn: process.env.TOPIC_ARN,
      MessageAttributes: {
        type: {
          DataType: "String",
          StringValue: requestBody.type,
        },
      },
    };
    const result = await sns.publish(params).promise();

    // Send get and post data to separate SQS queues
    if (requestBody.type === "stock") {
      const stockParams = {
        MessageBody: JSON.stringify(requestBody),
        QueueUrl: stockQueueUrl,
      };
      await sqs.sendMessage(stockParams).promise();
    } else if (requestBody.type === "attendance") {
      const attendanceParams = {
        MessageBody: JSON.stringify(requestBody),
        QueueUrl: attendanceQueueUrl,
      };
      await sqs.sendMessage(attendanceParams).promise();
    } else if (requestBody.type === "reward") {
      const rewardParams = {
        MessageBody: JSON.stringify(requestBody),
        QueueUrl: rewardQueueUrl,
      };
      await sqs.sendMessage(rewardParams).promise();
    }

    return {
      statusCode: 200,
      body: JSON.stringify({ message: "SNS 주제 및 SQS 대기열로 메세지 전달 완료", result }),
    };
  } catch (err) {
    console.error(err);
    return {
      statusCode: 400,
      body: JSON.stringify({ message: "Internal Server Error" }),
    };
  }
};
