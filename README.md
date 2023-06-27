# terraform-azurerm-ithc-infrastructure

This module demonstrates the creation of the basic infrastructure required by the ITHC workflow.

The module itself aims to be environment agnostic, with variable assignments and data lookups dictating whether or not this should be a pre-production or a production deployment.

## structure

The structure of this module is incredibly verbose; this is done for demonstration purposes only. In practice, every resource could live in a single file if desired, but that doesn't help visualise the structure of what's being created.