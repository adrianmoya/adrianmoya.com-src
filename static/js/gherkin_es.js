function(hljs) {
  return {
      contains: [
        {
          className: 'keyword',
          begin: '^\\s*(Pero |Y |Entonces |Cuando |Dadas |Dados |Dada |Dado |\\* |Ejemplos|Esquema del escenario|Escenario|Antecedentes|Característica)',
          relevance: 0
        },
        {
          className: 'string',
          begin: '\\|',
          relevance: 0
        },
        hljs.HASH_COMMENT_MODE,
        {
          className: 'string',
          begin: '"""', end: '"""',
          relevance: 10
        },
        hljs.APOS_STRING_MODE, 
        hljs.QUOTE_STRING_MODE,
        hljs.C_NUMBER_MODE,
        {
          className: 'annotation', begin: '@[^@\r\n\t ]+'
        }
      ]
  }
}
