ADMIN_USERNAME = "admin" unless ENV['ADMIN_USERNAME']
ADMIN_PASSWORD = "passw0rd" unless ENV['ADMIN_PASSWORD']

LAST_FM_USERNAME = "samsoffes"
LAST_FM_API_KEY = (ENV['LAST_FM_API_KEY'] or "b25b959554ed76058ac220b7b2e0a026")
LAST_FM_API_SECRET = (ENV['LAST_FM_API_SECRET'] or nil)
