'use strict'

module.exports = async function (fastify, opts) {
  fastify.get('/:user_id', async function (request, reply) {
    return 'this is attendance check' + request.params.user_id
  })
}
