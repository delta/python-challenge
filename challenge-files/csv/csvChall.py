import csv
from faker import Faker

fake = Faker()

totalRecords = 10000
diff = 8739

with open("./first.csv", "w") as f1, open("second.csv", "w") as f2:
    field1 = ["name", "city", "job", "bban"]
    field2 = ["name", "language", "phoneNumber"]
    x1 = csv.DictWriter(f1, fieldnames=field1)
    x2 = csv.DictWriter(f2, fieldnames=field2)
    x1.writeheader()
    x2.writeheader()
    for i in range(totalRecords):
        name = fake.first_name()
        x1.writerow({"name": name, "city": fake.city(), "job": fake.job(), "bban": fake.bban()})
        x2.writerow({"name": name if i == diff else fake.last_name(), "language": fake.language_name(), "phoneNumber": fake.phone_number()})
