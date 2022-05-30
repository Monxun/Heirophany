kubectl run image=nginx example --dry-run=client -o yaml | vi -
kubectl run image=nginx example --dry-run=client -o yaml > nginx-example.yaml