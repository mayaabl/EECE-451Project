from django.shortcuts import render
from rest_framework.response import Response

from rest_framework.decorators import api_view
from forms import *



def info_by_operator(request):
    if request.method == 'POST':
        form = OperatorForm(request.POST)
        if form.is_valid():
            data = form.cleaned_data
            start_date = data['start_date']
            end_date = data['end_date']
            operator = data['operator']

            ## Now we get all entries for this duration
            entries = NetworkEntry.objects.filter(date_and_time_range=(start_date, end_date))

            ## Now we get all entries with this operator name
            entries = entries.filter(operator=operator)
            average = entries.count/NetworkEntry.objects.count

            return render(request, 'results.html', {'average':average, 'operator':operator})
    else:
        form = OperatorForm()
        return render(request, 'operator_form.html', {'form': form})


def connectivity_per_network(request):
    if request.method == 'POST':
        form = NetworkForm(request.POST)
        if form.is_valid():
            data = form.cleaned_data
            start_date = data['start_date']
            end_date = data['end_date']
            network_type = data['network_type']

            ## Now we get all entries for this duration
            entries = NetworkEntry.objects.filter(date_and_time_range=(start_date, end_date))

            ## Now we get all entries with this operator name
            entries = entries.filter(network_type=network_type)
            average = entries.count/NetworkEntry.objects.count

            return render(request, 'results.html', {'average':average, 'network_type':network_type})
    else:
        form = NetworkForm()
        return render(request, 'connectivity_form.html', {'form': form})


def power_per_network(request):
    if request.method == 'POST':
        form = NetworkForm(request.POST)
        if form.is_valid():
            data = form.cleaned_data
            start_date = data['start_date']
            end_date = data['end_date']
            network_type = data['network_type']

            ## Now we get all entries for this duration
            entries = NetworkEntry.objects.filter(date_and_time_range=(start_date, end_date))

            ## Now we get all entries with this operator name
            entries = entries.filter(network_type=network_type)
            average = entries.rating_set.aggregate(Avg('signal_power')).values()[0]
            return render(request, 'results.html', {'average':average, 'network_type':network_type})
    else:
        form = NetworkForm()
        return render(request, 'power_per_network_form.html', {'form': form})


def power_per_user(request):
    if request.method == 'POST':
        form = UserForm(request.POST)
        if form.is_valid():
            data = form.cleaned_data
            start_date = data['start_date']
            end_date = data['end_date']
            user = data['user']

            ## Now we get all entries for this duration
            entries = NetworkEntry.objects.filter(date_and_time_range=(start_date, end_date))

            ## Now we get all entries with this operator name
            entries = entries.filter(user=user)
            average = entries.rating_set.aggregate(Avg('signal_power')).values()[0]
            return render(request, 'results.html', {'average':average, 'user':user})
    else:
        form = NetworkForm()
        return render(request, 'power_per_user_form.html', {'form': form})


def snr_per_network(request):
    if request.method == 'POST':
        form = NetworkForm(request.POST)
        if form.is_valid():
            data = form.cleaned_data
            start_date = data['start_date']
            end_date = data['end_date']
            network_type = data['network_type']

            ## Now we get all entries for this duration
            entries = NetworkEntry.objects.filter(date_and_time_range=(start_date, end_date))

            ## Now we get all entries with this operator name
            entries = entries.filter(network_type=network_type)
            average = entries.rating_set.aggregate(Avg('snr')).values()[0]
            return render(request, 'results.html', {'average':average, 'network_type':network_type})
    else:
        form = NetworkForm()
        return render(request, 'snr_per_network_form.html', {'form': form})






@api_view(['GET'])
def send_message(request):#send data needed to users

    routes =[#statistics should be calculated between time period chosen by the user.
            {

                'Endpoint':'/operator_average',
                'Method':'GET',
                'Body':'{"message":"Hello from  connectivity time per operator"}',
                'description':'Average connectivity time per operator'
            },
            {

                'Endpoint':'/ntype_average',
                'Method':'GET',
                'Body':'{"message":"Hello from  connectivity time per network type"}',
                'description':'Average connectivity time per network typ'
            },

            {

                'Endpoint':'/power_ntype',
                'Method':'GET',
                'Body':'{"message":"Hello from power per network type"}',
                'description':'Average connectivity time per operator'
            },
            {

                'Endpoint':'/power_device',
                'Method':'GET',
                'Body':'{"message":"Hello from Signal power per device"}',
                'description':'Average Signal power per device'
            },
            {

                'Endpoint':'/SNR_average',
                'Method':'GET',
                'Body':'{"message":"Hello from SNR "}',
                'description':'Average SNR or SINR per network type '
            }



    ]

    return Response(routes)

@api_view(['POST'])
def receive_message(request):#recieve data from users
    routes =[#ENDpoints could be joined
            {

                'Endpoint':'/operator',
                'Method':'POST',
                'Body':'{"message":"Hello from operator"}',
                'description':'operator'
            },
                {

                'Endpoint':'/SignalPower',
                'Method':'POST',
                'Body':'{"message":"Hello from Signal Power"}',
                'description':'Signal Power'
            },
                {

                'Endpoint':'/SINR',
                'Method':'POST',
                'Body':'{"message":"Hello from SINR"}',
                'description':'SINR'
            },
                {

                'Endpoint':'/NType',
                'Method':'POST',
                'Body':'{"message":"Hello from Network Type"}',
                'description':'Network Type'
            },
                {

                'Endpoint':'/Frequency',
                'Method':'POST',
                'Body':'{"message":"Hello from Frequency"}',
                'description':'Frequencyband'
            },
                 {

                'Endpoint':'/cellid',
                'Method':'POST',
                'Body':'{"message":"Hello from Cell ID"}',
                'description':'Cell ID'
            },
                 {

                'Endpoint':'/TimeStamp',
                'Method':'POST',
                'Body':'{"message":"Hello from Time Stamp"}',
                'description':'Time Stamp'
            },

    ]
    return Response(routes)




def home(request):

    return render(request,'home.html' )
