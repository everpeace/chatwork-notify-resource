# ChatWork notification sending resource
sending messagest to [ChatWork](https://www.chatwork.com/)

_Note: This is still alpha and my personal project._

# How to use it.
```
---
# first, define resource type.
resource_types:
  - name: chatwork-notify-resource
    type: docker-image
    source:
      repository: everpeace/chatwork-notify-resource

# second, declare your chatwork notification resource
resources:
  - name: chatwork-notification
    type: chatwork-notify-resource
    source:
      api_endpoint: https://api.chatwork.com/v1

jobs:
  - name: test-chatwork-notify
    serial: true
    plan:
      - task: dummy-test
        config:
          platform: linux
          outputs:
            - name: chatwork-notify
          run:
            path: sh
            args:
              - -exc
              - |
                echo "Hoooley! Dummy Test passed!" > chatwork-notify/test_result
# you can use 'put' chatwork-notification resourse.
      - put: chatwork-notification
        params:
          api_token: {{chatwork-api-token}}
          room: {{chatwork-room-to-notify}}
          text_file: chatwork-notify/test_result
          # $TEXT_FILE_CONTENT will be replaced with content of 'text_file' parameter.
          text: |
                [info][title]Test Results from Concourse[/title]:
                ${TEXT_FILE_CONTENT}[hr]url: $ATC_EXTERNAL_URL/pipelines/$BUILD_PIPELINE_NAME/jobs/$BUILD_JOB_NAME/builds/$BUILD_NAME
                [/info]
```
