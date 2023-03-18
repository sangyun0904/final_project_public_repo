const fp = require('fastify-plugin')
 
module.exports = fp(async function (fastify, opts) {
    fastify.register(require('fastify-dynamodb'), {
        endpoint: 'vpce-068a9f16367c7e1b9',
        region: "ap-northeast-2"
    })
})