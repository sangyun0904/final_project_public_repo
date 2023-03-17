const AWS = require('aws-sdk');
const dynamodb = new AWS.DynamoDB();
const ses = new AWS.SES();

exports.handler = async(event) => {
    try {
      const params = {
        TableName: 'Products',
        ProjectionExpression: 'id',
      };

      const data = await dynamodb.scan(params).promise();
      const allProductIds = data.Items.map(item => item.id.N);
      const emailParams = {
        Destination: {
          ToAddresses: ['rlawlgnswns@naver.com']
        },
        Message: {
          Body: {
            Text: {
              Data: `Remaining stock status: ${allProductIds.join(', ')}.`
            }
          },
          Subject: {
            Data: '일일 남은 재고 수량 알림'
          }
        },
        Source: 'rlawlgnswns@naver.com'
      };
      
      if (allProductIds.length > 0) {
        await ses.sendEmail(emailParams).promise();
      }
    
      return {
        statusCode: 200,
        body: JSON.stringify('Stock check completed')
      };
    } catch (err) {
      console.log(err);
      return {
        statusCode: 500,
        body: JSON.stringify('Error checking stock')
      };
    }
};
