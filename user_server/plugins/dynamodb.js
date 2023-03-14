const fp = require('fastify-plugin')
 
module.exports = fp(async function (fastify, opts) {
    fastify.register(require('fastify-dynamodb'), {
        endpoint: 'http://dynamodb-local:8000',
        region: "ap-northeast-2"
    })
})