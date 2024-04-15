How to fix this error?

Using WasmStorageImplementation.sharedIndexedDb due to unsupported browser features:
{MissingBrowserFeature.dedicatedWorkersInSharedWorkers, MissingBrowserFeature.sharedArrayBuffers}

### Running on Web gives us this address

http://localhost:64302/

### Enable Headers for WASM

https://pub.dev/documentation/drift/latest/drift.wasm/WasmStorageImplementation.html

dhttpd '--headers=Cross-Origin-Embedder-Policy=require-corp;Cross-Origin-Opener-Policy=same-origin;Content-Type: application/wasm'
Server started on port 8080

http://localhost:8080/

<!-- Cross-Origin-Opener-Policy: same-origin
Cross-Origin-Embedder-Policy: require-corp -->
