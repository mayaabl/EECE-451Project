from django.db import models

# Create your models here.



class User(models.Model):
    id = models.AutoField(primary_key=True)
    ip = models.IPAddressField()
    mac = models.BinaryField()

    def __str__(self):
        return f"IP: {str(self.ip)} ; MAC: {str(self.mac)}"


# class Operator(models.Model):
#     id = models.AutoField(primary_key=True)
#     name = models.CharField(max_length=128)

class NetworkEntry(models.Model):
    date_and_time = models.DateTimeField(auto_now=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    operator = models.CharField(max_length=128)
    signal_power = models.FloatField()
    SNR = models.FloatField()
    network_type = models.CharField(max_length=128)

    
