package test

import (
    "testing"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraform(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../",
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	// Test the creation of VPC
	t.Run("TestVPC", func(t *testing.T) {
		vpcID := terraform.Output(t, terraformOptions, "vpc_id")
		assert.NotEmpty(t, vpcID)
	})

	// Test the existence of subnets
	t.Run("TestSubnets", func(t *testing.T) {
		subnetIDs := terraform.OutputList(t, terraformOptions, "subnet_ids")
		assert.NotEmpty(t, subnetIDs)
		assert.Equal(t, 2, len(subnetIDs))
	})

	// Test the creation of security groups
	t.Run("TestSecurityGroups", func(t *testing.T) {
		securityGroupIDs := terraform.OutputList(t, terraformOptions, "security_group_ids")
		assert.NotEmpty(t, securityGroupIDs)
		assert.Equal(t, 2, len(securityGroupIDs))
	})

	// Test the creation of EC2 instances
	t.Run("TestEC2Instances", func(t *testing.T) {
		instanceIDs := terraform.OutputList(t, terraformOptions, "instance_ids")
		assert.NotEmpty(t, instanceIDs)
		assert.Equal(t, 2, len(instanceIDs))
	})

	// Test the existence of S3 bucket
	t.Run("TestS3Bucket", func(t *testing.T) {
		bucketName := terraform.Output(t, terraformOptions, "bucket_name")
		assert.NotEmpty(t, bucketName)
	})
}