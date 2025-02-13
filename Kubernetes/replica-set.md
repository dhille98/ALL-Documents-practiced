## Replicaset

* in kubernetes replicaset maintended a pods. it is run on loops for explane you can delete pod `RP` will create a new `pod ` 
* replicaset idntifies the pod on `lables`

```sh
    kubectl scale rs demoapp --replicas=6
```

* in pods attcahed to lables ` kubectl lbel pod testpod1 tier=demoapp`
* in replicaset update image frist of ll create attached image manifast
* `kubectl edit rs <name-rs>` change the image-name/tag
* `RS` automatically not update image you can delete older version pods that time update  the pods version 

