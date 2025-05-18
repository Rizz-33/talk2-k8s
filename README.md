# Build with AI with Gemini: Let's talk to your cluster - LLM Agents powered Kubernetes MCP Server 

## Resources
- [Cloud Credits](https://trygcp.dev/e/build-ai-SRIC01)
- [GCP Console](https://console.cloud.google.com/)

## Pre Requisites
- [GCloud CLI] (https://cloud.google.com/sdk/docs/install)
- Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
- Kubernetes cluster running 
- Install [kubectl-ai](https://github.com/GoogleCloudPlatform/kubectl-ai)

## Setup
1. Create Kubernetes cluster on Google Cloud
2. Create a Gemini API key from (https://aistudio.google.com/apikey)
3. Export the API key as an environment variable 
```bash
export GEMINI_API_KEY=<API_KEY>

```
4. Open a terminal and run the following command to start the kubectl-ai
```
kubectl-ai --model gemini-2.5-pro-exp-03-25  
```
or 

```
kubectl-ai --model gemini-2.5-flash-preview-04-17
```
### Additional Tips

Add a [Kubernetes MCP server](https://github.com/manusa/kubernetes-mcp-server) (Optional)

```bash
code --add-mcp '{"name":"kubernetes","command":"npx","args":["kubernetes-mcp-server@latest"]}'

```

## Talk to Cluster Challenge
1. Apply the following command to get started
```bash
kubectl apply -f https://raw.githubusercontent.com/chamodshehanka/talk2-k8s/refs/heads/main/bwai-manifests.yaml
```
2. Complete the challenge by using the kubectl-ai
3. Validate the challenge by running the following command
```bash
chmod +x ./validate.sh
./validate.sh
```
