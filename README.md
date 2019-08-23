# Marvel CleanCode Swift

Aplicativo desenvolvido utilizando VIP Clean Code.

## API

Para testar o app você vai precisar gerar suas chaves da API Marvel. 
Mais informações: https://developer.marvel.com/docs.

Incluir no diretório Build Config, os arquivos:

debug.xcconfig
release.xcconfig
```
PUBLIC_KEY = /* chave pública */
PRIVATE_KEY = /* chave privada */
```

## Instruções de instalação

Este projeto utiliza [Bundler](http://bundler.io) e [CocoaPods](https://cocoapods.org), confira se já estão instalados e depois execute os comandos abaixo no terminal:
```
bundle
bundle exec pod install
```

## Para testes e cobertura

Para executar os testes e verificar a cobertura, execute o comando abaixo:
```
bundle exec fastlane test
```
