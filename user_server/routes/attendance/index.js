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
    fastify.get('/:user_id', async function (request, reply) {
        let data

        // Set the parameters
        const params = {
            TableName: "Attendance", //TABLE_NAME
            FilterExpression : 'user_id = :id',
            ExpressionAttributeValues : {':id' : request.params.user_id}
        };

        try {
            data = await fastify.dynamo.scan(params).promise();
        } catch (e) {
            reply.send(e)
        }

        return 'this is attendance check' + request.params.user_id + "\n attendance : " + JSON.stringify(data)
    })

    fastify.post('/attend', async function (request, reply) {
        let data
        let day = new Date()

        // Set the parameters
        const params = {
            TableName : 'Attendance',
            Item: {
               id: generateRowId(request.body.userId),
               date: day.getTime(),
               user_id: request.body.userId
            }
        };

        await fastify.dynamo.put(params, function(err, data) {
            if (err) console.log(err);
        });

        return console.log(data)
    })
  }
