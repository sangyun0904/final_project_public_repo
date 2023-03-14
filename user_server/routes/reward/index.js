'use strict'

module.exports = async function (fastify, opts) {
    fastify.get('/', async function (request, reply) {
        return 'this is reward'
    })

    fastify.get('/all/:user_id', async function (request, reply) {
        return 'this is reward items check user: ' + request.params.user_id
    })

    fastify.get('/item/:product_id/:user_id', async function (request, reply) {
        return 'this is reward item check product: ' + request.params.product_id + ' user: ' + request.params.user_id
    })

    fastify.post('/item/:product_id/:user_id', async function (request, reply) {
        return { root: true }
    })
}