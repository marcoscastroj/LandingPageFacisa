const fs = require('fs');
const assert = require('assert');

assert.ok(fs.existsSync('index.html'), 'O arquivo index.html não foi encontrado.');
console.log('✔ Teste 1/2: index.html existe.');

const indexContent = fs.readFileSync('index.html', 'utf8');
assert.ok(indexContent.includes('<title>Kaio & Miguel | Landing Page</title>'), 'O título da página não está correto.');
console.log('✔ Teste 2/2: Título da página está correto.');

console.log('\nTodos os testes passaram com sucesso!');