module.exports = {
    'env': {
        'commonjs': true,
        'es2021': true,
        'node': true,
    },
    'extends': [
        'google',
    ],
    'parser': '@typescript-eslint/parser',
    'parserOptions': {
        'ecmaVersion': 12,
        'createDefaultProgram': true,
        'project': [
            './tsconfig.json',
        ],
    },
    'plugins': [
        '@typescript-eslint',
    ],
    'rules': {
        'comma-dangle': [
            'error',
            {
                'arrays': 'always',
                'objects': 'always',
            },
        ],
        'object-property-newline': 'error',
        'array-element-newline': 'error',
        'require-jsdoc': 'off',
        'indent': 'off',
        'max-params': [
            'error',
            3,
        ],
        'max-len': [
            'error',
            {
                'ignoreComments': true,
                'ignorePattern': '^import .*',
            },
        ],
        '@typescript-eslint/prefer-readonly-parameter-types': [
            'error',
            {
                'ignoreInferredTypes': true,
            },
        ],
        'eqeqeq': [
            'error',
            'always',
        ],
    },
};
