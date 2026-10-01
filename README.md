# inv_nopixel

Inventário moderno para FiveM/Qbox, inspirado na experiência do NoPixel e com uma camada de compatibilidade para a API do `ox_inventory`.

> **Status:** base funcional/extensível. A integração preserva os nomes das exports/eventos mais comuns, mas deve ser validada na sua base antes de produção.

## Recursos

- Slots, peso máximo e itens com metadata.
- Drag-and-drop, stack, uso e descarte.
- Compatibilidade com Qbox e fallback para `ox_inventory`.
- API server-side para adicionar, remover, consultar e usar itens.
- Persistência desacoplada: usa Qbox quando disponível e mantém um provider simples para desenvolvimento.
- NUI leve, responsiva e sem dependências externas.

## Instalação

1. Coloque `inv_nopixel` em `resources/[inventory]/`.
2. Garanta a ordem:

```cfg
ensure ox_lib
ensure qbx_core
ensure ox_inventory
ensure inv_nopixel
```

3. Revise `shared/config.lua` e os itens da sua base.
4. Reinicie o recurso e abra com `/inventory`.

## Compatibilidade

A camada pública expõe:

```lua
exports.inv_nopixel:openInventory('player')
exports.inv_nopixel:closeInventory()
exports.inv_nopixel:AddItem(source, 'water', 1, {})
exports.inv_nopixel:RemoveItem(source, 'water', 1)
exports.inv_nopixel:HasItem(source, 'water', 1)
exports.inv_nopixel:GetInventory(source)
```

Também são registrados aliases de eventos para facilitar a migração. Não remova o `ox_inventory` até validar todos os recursos da sua cidade.

## Próximos passos recomendados

- Conectar o provider de persistência ao schema usado pela sua versão do Qbox.
- Substituir o placeholder de imagens pelos ícones da sua base.
- Adicionar inventários de baú, porta-malas, luvas e stash.
- Testar limites de peso, dupe protection e permissões em ambiente de homologação.

## Licença

MIT. Consulte `LICENSE`.
