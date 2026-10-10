resource "aws_appmesh_route" "appmesh_routes" {
  for_each = var.appmesh_routes

  mesh_name           = each.value.mesh_name
  name                = each.value.name
  virtual_router_name = each.value.virtual_router_name
  mesh_owner          = each.value.mesh_owner
  region              = each.value.region
  tags                = each.value.tags
  tags_all            = each.value.tags_all

  spec {
    dynamic "grpc_route" {
      for_each = each.value.spec.grpc_route != null ? [each.value.spec.grpc_route] : []
      content {
        action {
          dynamic "weighted_target" {
            for_each = grpc_route.value.action.weighted_target
            content {
              port         = weighted_target.value.port
              virtual_node = weighted_target.value.virtual_node
              weight       = weighted_target.value.weight
            }
          }
        }
        dynamic "match" {
          for_each = grpc_route.value.match != null ? [grpc_route.value.match] : []
          content {
            dynamic "metadata" {
              for_each = match.value.metadata != null ? match.value.metadata : []
              content {
                invert = metadata.value.invert
                dynamic "match" {
                  for_each = metadata.value.match != null ? [metadata.value.match] : []
                  content {
                    exact  = match.value.exact
                    prefix = match.value.prefix
                    dynamic "range" {
                      for_each = match.value.range != null ? [match.value.range] : []
                      content {
                        end   = range.value.end
                        start = range.value.start
                      }
                    }
                    regex  = match.value.regex
                    suffix = match.value.suffix
                  }
                }
                name = metadata.value.name
              }
            }
            method_name  = match.value.method_name
            port         = match.value.port
            prefix       = match.value.prefix
            service_name = match.value.service_name
          }
        }
        dynamic "retry_policy" {
          for_each = grpc_route.value.retry_policy != null ? [grpc_route.value.retry_policy] : []
          content {
            grpc_retry_events = retry_policy.value.grpc_retry_events
            http_retry_events = retry_policy.value.http_retry_events
            max_retries       = retry_policy.value.max_retries
            per_retry_timeout {
              unit  = retry_policy.value.per_retry_timeout.unit
              value = retry_policy.value.per_retry_timeout.value
            }
            tcp_retry_events = retry_policy.value.tcp_retry_events
          }
        }
        dynamic "timeout" {
          for_each = grpc_route.value.timeout != null ? [grpc_route.value.timeout] : []
          content {
            dynamic "idle" {
              for_each = timeout.value.idle != null ? [timeout.value.idle] : []
              content {
                unit  = idle.value.unit
                value = idle.value.value
              }
            }
            dynamic "per_request" {
              for_each = timeout.value.per_request != null ? [timeout.value.per_request] : []
              content {
                unit  = per_request.value.unit
                value = per_request.value.value
              }
            }
          }
        }
      }
    }
    dynamic "http2_route" {
      for_each = each.value.spec.http2_route != null ? [each.value.spec.http2_route] : []
      content {
        action {
          dynamic "weighted_target" {
            for_each = http2_route.value.action.weighted_target
            content {
              port         = weighted_target.value.port
              virtual_node = weighted_target.value.virtual_node
              weight       = weighted_target.value.weight
            }
          }
        }
        match {
          dynamic "header" {
            for_each = http2_route.value.match.header != null ? http2_route.value.match.header : []
            content {
              invert = header.value.invert
              dynamic "match" {
                for_each = header.value.match != null ? [header.value.match] : []
                content {
                  exact  = match.value.exact
                  prefix = match.value.prefix
                  dynamic "range" {
                    for_each = match.value.range != null ? [match.value.range] : []
                    content {
                      end   = range.value.end
                      start = range.value.start
                    }
                  }
                  regex  = match.value.regex
                  suffix = match.value.suffix
                }
              }
              name = header.value.name
            }
          }
          method = http2_route.value.match.method
          dynamic "path" {
            for_each = http2_route.value.match.path != null ? [http2_route.value.match.path] : []
            content {
              exact = path.value.exact
              regex = path.value.regex
            }
          }
          port   = http2_route.value.match.port
          prefix = http2_route.value.match.prefix
          dynamic "query_parameter" {
            for_each = http2_route.value.match.query_parameter != null ? http2_route.value.match.query_parameter : []
            content {
              dynamic "match" {
                for_each = query_parameter.value.match != null ? [query_parameter.value.match] : []
                content {
                  exact = match.value.exact
                }
              }
              name = query_parameter.value.name
            }
          }
          scheme = http2_route.value.match.scheme
        }
        dynamic "retry_policy" {
          for_each = http2_route.value.retry_policy != null ? [http2_route.value.retry_policy] : []
          content {
            http_retry_events = retry_policy.value.http_retry_events
            max_retries       = retry_policy.value.max_retries
            per_retry_timeout {
              unit  = retry_policy.value.per_retry_timeout.unit
              value = retry_policy.value.per_retry_timeout.value
            }
            tcp_retry_events = retry_policy.value.tcp_retry_events
          }
        }
        dynamic "timeout" {
          for_each = http2_route.value.timeout != null ? [http2_route.value.timeout] : []
          content {
            dynamic "idle" {
              for_each = timeout.value.idle != null ? [timeout.value.idle] : []
              content {
                unit  = idle.value.unit
                value = idle.value.value
              }
            }
            dynamic "per_request" {
              for_each = timeout.value.per_request != null ? [timeout.value.per_request] : []
              content {
                unit  = per_request.value.unit
                value = per_request.value.value
              }
            }
          }
        }
      }
    }
    dynamic "http_route" {
      for_each = each.value.spec.http_route != null ? [each.value.spec.http_route] : []
      content {
        action {
          dynamic "weighted_target" {
            for_each = http_route.value.action.weighted_target
            content {
              port         = weighted_target.value.port
              virtual_node = weighted_target.value.virtual_node
              weight       = weighted_target.value.weight
            }
          }
        }
        match {
          dynamic "header" {
            for_each = http_route.value.match.header != null ? http_route.value.match.header : []
            content {
              invert = header.value.invert
              dynamic "match" {
                for_each = header.value.match != null ? [header.value.match] : []
                content {
                  exact  = match.value.exact
                  prefix = match.value.prefix
                  dynamic "range" {
                    for_each = match.value.range != null ? [match.value.range] : []
                    content {
                      end   = range.value.end
                      start = range.value.start
                    }
                  }
                  regex  = match.value.regex
                  suffix = match.value.suffix
                }
              }
              name = header.value.name
            }
          }
          method = http_route.value.match.method
          dynamic "path" {
            for_each = http_route.value.match.path != null ? [http_route.value.match.path] : []
            content {
              exact = path.value.exact
              regex = path.value.regex
            }
          }
          port   = http_route.value.match.port
          prefix = http_route.value.match.prefix
          dynamic "query_parameter" {
            for_each = http_route.value.match.query_parameter != null ? http_route.value.match.query_parameter : []
            content {
              dynamic "match" {
                for_each = query_parameter.value.match != null ? [query_parameter.value.match] : []
                content {
                  exact = match.value.exact
                }
              }
              name = query_parameter.value.name
            }
          }
          scheme = http_route.value.match.scheme
        }
        dynamic "retry_policy" {
          for_each = http_route.value.retry_policy != null ? [http_route.value.retry_policy] : []
          content {
            http_retry_events = retry_policy.value.http_retry_events
            max_retries       = retry_policy.value.max_retries
            per_retry_timeout {
              unit  = retry_policy.value.per_retry_timeout.unit
              value = retry_policy.value.per_retry_timeout.value
            }
            tcp_retry_events = retry_policy.value.tcp_retry_events
          }
        }
        dynamic "timeout" {
          for_each = http_route.value.timeout != null ? [http_route.value.timeout] : []
          content {
            dynamic "idle" {
              for_each = timeout.value.idle != null ? [timeout.value.idle] : []
              content {
                unit  = idle.value.unit
                value = idle.value.value
              }
            }
            dynamic "per_request" {
              for_each = timeout.value.per_request != null ? [timeout.value.per_request] : []
              content {
                unit  = per_request.value.unit
                value = per_request.value.value
              }
            }
          }
        }
      }
    }
    priority = each.value.spec.priority
    dynamic "tcp_route" {
      for_each = each.value.spec.tcp_route != null ? [each.value.spec.tcp_route] : []
      content {
        action {
          dynamic "weighted_target" {
            for_each = tcp_route.value.action.weighted_target
            content {
              port         = weighted_target.value.port
              virtual_node = weighted_target.value.virtual_node
              weight       = weighted_target.value.weight
            }
          }
        }
        dynamic "match" {
          for_each = tcp_route.value.match != null ? [tcp_route.value.match] : []
          content {
            port = match.value.port
          }
        }
        dynamic "timeout" {
          for_each = tcp_route.value.timeout != null ? [tcp_route.value.timeout] : []
          content {
            dynamic "idle" {
              for_each = timeout.value.idle != null ? [timeout.value.idle] : []
              content {
                unit  = idle.value.unit
                value = idle.value.value
              }
            }
          }
        }
      }
    }
  }
}

