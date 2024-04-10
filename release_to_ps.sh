source .env
curl -H "Content-Type: application/json" \
       -H "x-auth-token: $AUTH_TOKEN" \
       --data '{
         "appId": "6596e604a2370360888389ed",
         "workflowId": "6596e604a2370360888389ec",
         "branch": "main"
       }' \
       https://api.codemagic.io/builds

echo -e "\nBuild started..."
