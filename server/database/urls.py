from . import views
from django.urls import path

urlpatterns = [
   
    path('',views.home, name='homefunc'),
    path('send_message/',views.send_message, name='send_message'),
    path('receive_message/',views.receive_message, name='receive_message'),
]