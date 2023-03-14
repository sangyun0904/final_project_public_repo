'use strict'

module.exports = async function (fastify, opts) {
    fastify.get('/:user_id', async function (request, reply) {
  
        let data

        // Set the parameters
        const params = {
            TableName: "attendance", //TABLE_NAME
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
  }