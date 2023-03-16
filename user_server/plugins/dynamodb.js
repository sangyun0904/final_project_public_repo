const fp = require('fastify-plugin')
 
module.exports = fp(async function (fastify, opts) {
    fastify.register(require('fastify-dynamodb'), {
        endpoint: 'com.amazonaws.ap-northeast-2.dynamodb',
        region: "ap-northeast-2"
    })
})