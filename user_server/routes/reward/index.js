'use strict'

var CUSTOMEPOCH = 1300000000000; // artificial epoch
function generateRowId(shardId) {
    const d = new Date()
    var ts = d.getTime() - CUSTOMEPOCH; // limit to recent
    var randid = Math.floor(Math.random() * 512);
    ts = (ts * 64);   // bit-shift << 6
    ts = ts + shardId;
    return (ts * 512) + randid;
}

module.exports = async function (fastify, opts) {
    fastify.get('/', async function (request, reply) {
        return 'this is reward'
    })

    fastify.get('/all/:user_id/:username', async function (request, reply) {
        let c
        let data

        // Set the parameters
        const params = {
            TableName: "Users",
            Key: {
              id: parseInt(request.params.user_id),
              username: request.params.username
            },
        };

        try {
            c = await fastify.dynamo.get(params).promise();
            c = c.Item.count
        } catch (e) {
            reply.send(e)
        }

        const params2 = {
            TableName: "Products", //TABLE_NAME
            FilterExpression : 'con <= :count',
            ExpressionAttributeValues : {':count' : c}
        };

        try {
            data = await fastify.dynamo.scan(params2).promise();
        } catch (e) {
            reply.send(e)
        }

        return 'this is reward items check user: ' + JSON.stringify(data)
    })

    fastify.get('/item/:product_id/:user_id/:username', async function (request, reply) {

        let user 
        let item
        let cou
        let con

        // Set the parameters
        let params = {
            TableName: "Users",
            Key: {
              id: parseInt(request.params.user_id),
              username: request.params.username
            },
        };

        try {
            user = await fastify.dynamo.get(params).promise();
            cou = user.Item.count
        } catch (e) {
            reply.send(e)
        }

        // Set the parameters
        params = {
            TableName: "Products",
            Key: {
                id: parseInt(request.params.product_id)
            },
        };

        try {
            item = await fastify.dynamo.get(params).promise();
            con = item.Item.condition
        } catch (e) {
            reply.send(e)
        }

        if (con > cou) {
            return "아직 " + item.Item.name + "아이템을 지급받지 못합니다. \n" + user.Item.username + " 출석 : " + cou
        }
        else {
            item.Item.name + "아이템을 획득하셨습니다."
            params = {
                TableName: "Products",
                Key: { id : item.Item.id },
                UpdateExpression: "set #a = #a - :x",
                ExpressionAttributeNames: {'#a' : 'remain'},
                ExpressionAttributeValues: {
                    ':x' : 1
                }
            }
    
            await fastify.dynamo.update(params, function(err, data) {
                if (err) console.log(err);
                else console.log(data)
            })

            let data
            let day = new Date()

            let params = {
                TableName : 'Rewards',
                Item: {
                   id: generateRowId(item.Item.id),
                   product_id: item.Item.id,
                   reward_time: day.getDate(),
                   user_id: parseInt(request.body.userId)
                }
            };
    
            await fastify.dynamo.put(params, function(err, data) {
                if (err) console.log(err);
            });
        }

        return 'this is reward item check can reward? ' + (con <= cou)
    })

    fastify.get('/sqs', async function (request, reply) {
        var easy = require("easy-sqs");
 
        var awsConfig = {
            "accessKeyId": process.env.AWS_ACCESS_KEY_ID,
            "secretAccessKey": process.env.AWS_SECRET_ACCESS_KEY,
            "region": "ap-northeast-2"
        };
        
        var url = "https://sqs.ap-northeast-2.amazonaws.com/180693256225/request-product-queue";
        
        var client = easy.createClient(awsConfig);
        
        client.getQueue(url, function(err, queue){
        
            if(err) return "queue does not exist";
        
            //messages must be strings for now...
            var msg = JSON.stringify({body: "my message body"});
        
            queue.sendMessage(msg, function(err){
                    if(err) return "send failed!";
            });
            return msg
        });
    })

}