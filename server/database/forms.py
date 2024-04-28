from django.forms import ModelForm
from .models import *




class OperatorForm(ModelForm):
    model = NetworkEntry
    fields = ['start_date','end_date','operator_name']

class NetworkForm(ModelForm):
    model = NetworkEntry
    fields = ['start_date','end_date','network_type']

class UserForm(ModelForm):
    model = NetworkEntry
    fields = ['start_date','end_date','user']