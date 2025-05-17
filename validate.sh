#!/bin/bash

# Task 1: Function to validate replica count
check_replicas() {
  local deployment=$1
  local namespace=$2
  local expected=$3

  local actual
  actual=$(kubectl get deploy "$deployment" -n "$namespace" -o jsonpath='{.spec.replicas}')

  echo "$deployment replicas: $actual"

  if [ "$actual" -eq "$expected" ]; then
    echo "$deployment status: correct"
  else
    echo "$deployment status: invalid"
  fi
}

# Task 2: Function to check if image contains <INVALID_TAG>
check_image_tag() {
  local deployment=$1
  local namespace=$2
  local invalid_tag=$3

  local image
  image=$(kubectl get deploy "$deployment" -n "$namespace" -o jsonpath='{.spec.template.spec.containers[0].image}')

  echo "$deployment image: $image"

  if [[ "$image" == *"$invalid_tag"* ]]; then
    echo "$deployment status: invalid (contains <$invalid_tag>)"
  else
    echo "$deployment status: correct"
  fi
}

# Task 5: Validate Role and RoleBinding
check_role_binding() {
  local role_name=$1
  local role_binding_name=$2
  local sa_name=$3
  local namespace=$4

  # Check Role exists
  if kubectl get role "$role_name" -n "$namespace" &>/dev/null; then
    echo "Role $role_name: exists"
  else
    echo "Role $role_name: missing"
    return
  fi

  # Check RoleBinding exists
  if kubectl get rolebinding "$role_binding_name" -n "$namespace" &>/dev/null; then
    echo "RoleBinding $role_binding_name: exists"
  else
    echo "RoleBinding $role_binding_name: missing"
    return
  fi

  # Validate roleRef and subject
  local ref_role
  ref_role=$(kubectl get rolebinding "$role_binding_name" -n "$namespace" -o jsonpath='{.roleRef.name}')
  local subject_sa
  subject_sa=$(kubectl get rolebinding "$role_binding_name" -n "$namespace" -o jsonpath='{.subjects[0].name}')

  if [ "$ref_role" == "$role_name" ] && [ "$subject_sa" == "$sa_name" ]; then
    echo "RoleBinding $role_binding_name is correctly configured"
  else
    echo "RoleBinding $role_binding_name is misconfigured"
  fi
}

# ---- Run validations ----

# Task 1: Check if web-frontend has 3 replicas
check_replicas "web-frontend" "dev" 3

# Task 2: Check if bwai-server image contains <INVALID_TAG>
check_image_tag "bwai-server" "dev" "<INVALID_TAG>"

check_role_binding "pod-reader" "read-pods-binding" "my-service-account" "default"
