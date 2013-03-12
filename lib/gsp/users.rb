module GSP::Users
  module UserTypes
    GSP_ADMIN   = 10  # Developer access
    SUPERADMIN  = 8   # Can view all templates and organizations
    ADMIN       = 6   # Top-level user within a collection of organizations, view all within collection
    USER        = 4   # Normal constraints
  end
end
