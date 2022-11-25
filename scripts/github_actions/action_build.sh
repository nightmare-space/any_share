curl --location --request POST 'https://api.github.com/repos/nightmare-space/speed_share/actions/workflows/workflow_dispatch.yml/dispatches' \
    --header 'Authorization: token TOKEN_REMOVED' \
    --header 'Content-Type: application/json' \
    --data-raw '{
    "ref": "dev",
    "inputs": {
        "version": "2.1.10",
        "version_code": "57"
    }
}'
