resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "additionalProperties" = true,
        "properties" = {
            "conversationId" = {
                "type" = "string"
            },
            "key" = {
                "type" = "string"
            },
            "participantId" = {
                "type" = "string"
            },
            "value" = {
                "type" = "string"
            }
        },
        "type" = "object"
    })
    contract_output = jsonencode({
        "additionalProperties" = true,
        "properties" = {},
        "type" = "object"
    })
    
    config_request {
        request_template     = "{\n\"attributes\": { \"$${input.key}\": \"$!{input.value}\" }\n}"
        request_type         = "PATCH"
        request_url_template = "/api/v2/conversations/$${input.conversationId}/participants/$${input.participantId}/attributes"
        
    }

    config_response {
        success_template = "$${rawResult}"
         
               
    }
}