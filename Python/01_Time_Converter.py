# Convert minutes into human-readable format

minutes = int(input("Enter minutes: "))

hours = minutes // 60
remaining_minutes = minutes % 60

if hours == 1:
    hour_text = "1 hr"
else:
    hour_text = f"{hours} hrs"

if remaining_minutes == 1:
    minute_text = "1 minute"
else:
    minute_text = f"{remaining_minutes} minutes"

print(f"{hour_text} {minute_text}")