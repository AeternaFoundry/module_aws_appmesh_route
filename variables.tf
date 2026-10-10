variable "appmesh_routes" {
  description = <<EOT
Map of appmesh_routes, attributes below
Required:
    - mesh_name
    - name
    - virtual_router_name
    - spec (block):
        - grpc_route (optional, block):
            - action (required, block):
                - weighted_target (required, block):
                    - port (optional)
                    - virtual_node (required)
                    - weight (required)
            - match (optional, block):
                - metadata (optional, block):
                    - invert (optional)
                    - match (optional, block):
                        - exact (optional)
                        - prefix (optional)
                        - range (optional, block):
                            - end (required)
                            - start (required)
                        - regex (optional)
                        - suffix (optional)
                    - name (required)
                - method_name (optional)
                - port (optional)
                - prefix (optional)
                - service_name (optional)
            - retry_policy (optional, block):
                - grpc_retry_events (optional)
                - http_retry_events (optional)
                - max_retries (required)
                - per_retry_timeout (required, block):
                    - unit (required)
                    - value (required)
                - tcp_retry_events (optional)
            - timeout (optional, block):
                - idle (optional, block):
                    - unit (required)
                    - value (required)
                - per_request (optional, block):
                    - unit (required)
                    - value (required)
        - http2_route (optional, block):
            - action (required, block):
                - weighted_target (required, block):
                    - port (optional)
                    - virtual_node (required)
                    - weight (required)
            - match (required, block):
                - header (optional, block):
                    - invert (optional)
                    - match (optional, block):
                        - exact (optional)
                        - prefix (optional)
                        - range (optional, block):
                            - end (required)
                            - start (required)
                        - regex (optional)
                        - suffix (optional)
                    - name (required)
                - method (optional)
                - path (optional, block):
                    - exact (optional)
                    - regex (optional)
                - port (optional)
                - prefix (optional)
                - query_parameter (optional, block):
                    - match (optional, block):
                        - exact (optional)
                    - name (required)
                - scheme (optional)
            - retry_policy (optional, block):
                - http_retry_events (optional)
                - max_retries (required)
                - per_retry_timeout (required, block):
                    - unit (required)
                    - value (required)
                - tcp_retry_events (optional)
            - timeout (optional, block):
                - idle (optional, block):
                    - unit (required)
                    - value (required)
                - per_request (optional, block):
                    - unit (required)
                    - value (required)
        - http_route (optional, block):
            - action (required, block):
                - weighted_target (required, block):
                    - port (optional)
                    - virtual_node (required)
                    - weight (required)
            - match (required, block):
                - header (optional, block):
                    - invert (optional)
                    - match (optional, block):
                        - exact (optional)
                        - prefix (optional)
                        - range (optional, block):
                            - end (required)
                            - start (required)
                        - regex (optional)
                        - suffix (optional)
                    - name (required)
                - method (optional)
                - path (optional, block):
                    - exact (optional)
                    - regex (optional)
                - port (optional)
                - prefix (optional)
                - query_parameter (optional, block):
                    - match (optional, block):
                        - exact (optional)
                    - name (required)
                - scheme (optional)
            - retry_policy (optional, block):
                - http_retry_events (optional)
                - max_retries (required)
                - per_retry_timeout (required, block):
                    - unit (required)
                    - value (required)
                - tcp_retry_events (optional)
            - timeout (optional, block):
                - idle (optional, block):
                    - unit (required)
                    - value (required)
                - per_request (optional, block):
                    - unit (required)
                    - value (required)
        - priority (optional)
        - tcp_route (optional, block):
            - action (required, block):
                - weighted_target (required, block):
                    - port (optional)
                    - virtual_node (required)
                    - weight (required)
            - match (optional, block):
                - port (optional)
            - timeout (optional, block):
                - idle (optional, block):
                    - unit (required)
                    - value (required)
Optional:
    - mesh_owner
    - region
    - tags
    - tags_all
EOT

  type = map(object({
    mesh_name           = string
    name                = string
    virtual_router_name = string
    mesh_owner          = optional(string)
    region              = optional(string)
    tags                = optional(map(string))
    tags_all            = optional(map(string))
    spec = object({
      grpc_route = optional(object({
        action = object({
          weighted_target = list(object({
            port         = optional(number)
            virtual_node = string
            weight       = number
          }))
        })
        match = optional(object({
          metadata = optional(list(object({
            invert = optional(bool)
            match = optional(object({
              exact  = optional(string)
              prefix = optional(string)
              range = optional(object({
                end   = number
                start = number
              }))
              regex  = optional(string)
              suffix = optional(string)
            }))
            name = string
          })))
          method_name  = optional(string)
          port         = optional(number)
          prefix       = optional(string)
          service_name = optional(string)
        }))
        retry_policy = optional(object({
          grpc_retry_events = optional(set(string))
          http_retry_events = optional(set(string))
          max_retries       = number
          per_retry_timeout = object({
            unit  = string
            value = number
          })
          tcp_retry_events = optional(set(string))
        }))
        timeout = optional(object({
          idle = optional(object({
            unit  = string
            value = number
          }))
          per_request = optional(object({
            unit  = string
            value = number
          }))
        }))
      }))
      http2_route = optional(object({
        action = object({
          weighted_target = list(object({
            port         = optional(number)
            virtual_node = string
            weight       = number
          }))
        })
        match = object({
          header = optional(list(object({
            invert = optional(bool)
            match = optional(object({
              exact  = optional(string)
              prefix = optional(string)
              range = optional(object({
                end   = number
                start = number
              }))
              regex  = optional(string)
              suffix = optional(string)
            }))
            name = string
          })))
          method = optional(string)
          path = optional(object({
            exact = optional(string)
            regex = optional(string)
          }))
          port   = optional(number)
          prefix = optional(string)
          query_parameter = optional(list(object({
            match = optional(object({
              exact = optional(string)
            }))
            name = string
          })))
          scheme = optional(string)
        })
        retry_policy = optional(object({
          http_retry_events = optional(set(string))
          max_retries       = number
          per_retry_timeout = object({
            unit  = string
            value = number
          })
          tcp_retry_events = optional(set(string))
        }))
        timeout = optional(object({
          idle = optional(object({
            unit  = string
            value = number
          }))
          per_request = optional(object({
            unit  = string
            value = number
          }))
        }))
      }))
      http_route = optional(object({
        action = object({
          weighted_target = list(object({
            port         = optional(number)
            virtual_node = string
            weight       = number
          }))
        })
        match = object({
          header = optional(list(object({
            invert = optional(bool)
            match = optional(object({
              exact  = optional(string)
              prefix = optional(string)
              range = optional(object({
                end   = number
                start = number
              }))
              regex  = optional(string)
              suffix = optional(string)
            }))
            name = string
          })))
          method = optional(string)
          path = optional(object({
            exact = optional(string)
            regex = optional(string)
          }))
          port   = optional(number)
          prefix = optional(string)
          query_parameter = optional(list(object({
            match = optional(object({
              exact = optional(string)
            }))
            name = string
          })))
          scheme = optional(string)
        })
        retry_policy = optional(object({
          http_retry_events = optional(set(string))
          max_retries       = number
          per_retry_timeout = object({
            unit  = string
            value = number
          })
          tcp_retry_events = optional(set(string))
        }))
        timeout = optional(object({
          idle = optional(object({
            unit  = string
            value = number
          }))
          per_request = optional(object({
            unit  = string
            value = number
          }))
        }))
      }))
      priority = optional(number)
      tcp_route = optional(object({
        action = object({
          weighted_target = list(object({
            port         = optional(number)
            virtual_node = string
            weight       = number
          }))
        })
        match = optional(object({
          port = optional(number)
        }))
        timeout = optional(object({
          idle = optional(object({
            unit  = string
            value = number
          }))
        }))
      }))
    })
  }))
  validation {
    condition = alltrue([
      for k, v in var.appmesh_routes : (
        v.spec.grpc_route == null || (length(v.spec.grpc_route.action.weighted_target) >= 1 && length(v.spec.grpc_route.action.weighted_target) <= 10)
      )
    ])
    error_message = "Each weighted_target list must contain between 1 and 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_routes : (
        v.spec.grpc_route == null || (v.spec.grpc_route.match == null || (v.spec.grpc_route.match.metadata == null || (length(v.spec.grpc_route.match.metadata) <= 10)))
      )
    ])
    error_message = "Each metadata list must contain at most 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_routes : (
        v.spec.http2_route == null || (length(v.spec.http2_route.action.weighted_target) >= 1 && length(v.spec.http2_route.action.weighted_target) <= 10)
      )
    ])
    error_message = "Each weighted_target list must contain between 1 and 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_routes : (
        v.spec.http2_route == null || (v.spec.http2_route.match.header == null || (length(v.spec.http2_route.match.header) <= 10))
      )
    ])
    error_message = "Each header list must contain at most 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_routes : (
        v.spec.http2_route == null || (v.spec.http2_route.match.query_parameter == null || (length(v.spec.http2_route.match.query_parameter) <= 10))
      )
    ])
    error_message = "Each query_parameter list must contain at most 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_routes : (
        v.spec.http_route == null || (length(v.spec.http_route.action.weighted_target) >= 1 && length(v.spec.http_route.action.weighted_target) <= 10)
      )
    ])
    error_message = "Each weighted_target list must contain between 1 and 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_routes : (
        v.spec.http_route == null || (v.spec.http_route.match.header == null || (length(v.spec.http_route.match.header) <= 10))
      )
    ])
    error_message = "Each header list must contain at most 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_routes : (
        v.spec.http_route == null || (v.spec.http_route.match.query_parameter == null || (length(v.spec.http_route.match.query_parameter) <= 10))
      )
    ])
    error_message = "Each query_parameter list must contain at most 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_routes : (
        v.spec.tcp_route == null || (length(v.spec.tcp_route.action.weighted_target) >= 1 && length(v.spec.tcp_route.action.weighted_target) <= 10)
      )
    ])
    error_message = "Each weighted_target list must contain between 1 and 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_routes : (
        length(v.mesh_name) >= 1 && length(v.mesh_name) <= 255
      )
    ])
    error_message = "must be between 1 and 255 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_routes : (
        v.spec.grpc_route == null || (v.spec.grpc_route.match == null || (v.spec.grpc_route.match.metadata == null || alltrue([for item in v.spec.grpc_route.match.metadata : (item.match == null || (item.match.exact == null || (length(item.match.exact) >= 1 && length(item.match.exact) <= 255)))])))
      )
    ])
    error_message = "must be between 1 and 255 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_routes : (
        v.spec.grpc_route == null || (v.spec.grpc_route.match == null || (v.spec.grpc_route.match.metadata == null || alltrue([for item in v.spec.grpc_route.match.metadata : (item.match == null || (item.match.regex == null || (length(item.match.regex) >= 1 && length(item.match.regex) <= 255)))])))
      )
    ])
    error_message = "must be between 1 and 255 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_routes : (
        v.spec.grpc_route == null || (v.spec.grpc_route.match == null || (v.spec.grpc_route.match.metadata == null || alltrue([for item in v.spec.grpc_route.match.metadata : (item.match == null || (item.match.suffix == null || (length(item.match.suffix) >= 1 && length(item.match.suffix) <= 255)))])))
      )
    ])
    error_message = "must be between 1 and 255 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_routes : (
        length(v.virtual_router_name) >= 1 && length(v.virtual_router_name) <= 255
      )
    ])
    error_message = "must be between 1 and 255 characters"
  }
  # Note: 18 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

