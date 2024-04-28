import rest_framework.serializers as serializers
import database.models as models

class ItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.NetworkEntry
        fields = '__all__' #can change it later