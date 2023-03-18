'use strict'

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

        let cou
        let con

        // Set the parameters
        const params = {
            TableName: "Users",
            Key: {
              id: parseInt(request.params.user_id),
              username: request.params.username
            },
        };

        try {
            cou = await fastify.dynamo.get(params).promise();
            cou = cou.Item.count
        } catch (e) {
            reply.send(e)
        }

        // Set the parameters
        const params1 = {
            TableName: "Products",
            Key: {
                id: parseInt(request.params.product_id)
            },
        };

        try {
            con = await fastify.dynamo.get(params1).promise();
            con = con.Item.con
        } catch (e) {
            reply.send(e)
        }

        return 'this is reward item check can reward? ' + (con <= cou)
    })

    fastify.post('/item/:product_id/:user_id', async function (request, reply) {
        return { root: true }
    })
}