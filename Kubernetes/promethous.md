# Monitoring Project 

## Project Components and Best Practices 
**Components**

**1.EC2 Instances:**

	- •	Instance 1: Hosts the web application, Node Exporter, and Nginx. 
	- •	Instance 2: Hosts Prometheus, Blackbox Exporter, and Alertmanager. 

**2.Prometheus:** Centralized monitoring tool for collecting and querying metrics. 

**3.Node Exporter:** Collects hardware and OS-level metrics from the web server. 

**4.Blackbox Exporter:** Probes endpoints to monitor uptime and response time. 

**5.Alertmanager:** Manages alerts sent by Prometheus based on defined rules. 

**6.Gmail Integration:** Sends email notifications for critical alerts. 


**Adjust security settings to allow necessary ports:** 
*	Prometheus: 9090 

*	Alert manager: 9093 

*	Blackbox Exporter: 9115 

*	Node Exporter: 9100 

*	Email transmissions: 587 

[ReferHere](https://prometheus.io/download/) download from this link [click](https://prometheus.io/download/#prometheus)

### Phase 2: Install and Configure Node Exporter and Deploy Web application on Instance 1 

**1.	Install Node Exporter:**
```
    cd /tmp
	Wget https://github.com/prometheus/node_exporter/releases/download/v1.8.1/node_exporter-1.8.1.linux-amd64.tar.gz 
	tar xvfz node_exporter-1.8.1.linux-amd64.tar.gz 
    mkdir /monataring && sudo mv node_exporter-1.8.1.linux-amd64 /monataring/node_exporter
	cd /monataring/node_exporter

	./node_exporter & 
```

2.	Install Nginx: sudo apt update sudo apt install nginx 
3.	Deploy Web Application(Java based Application) 

4.  take the applications [referhere](https://github.com/jaiswaladi246/Task-Master-Pro.git)

5. maven install and jdk-17 install 
6. depoloy the applications "java -jar " 



 
## Phase 3: Install and Configure Prometheus, Blackbox Exporter, and Alertmanager on Instance 2 

**1.Install Prometheus:**

```
wget 
https://github.com/prometheus/prometheus/releases/download/v2.52.0/prometheus-2.52.0.linux-amd64.tar.gz 
tar xvfz prometheus-2.52.0.linux-amd64.tar.gz cd prometheus-2.52.0.linux-amd64 
./prometheus --config.file=prometheus.yml & 
```
**2.Install Blackbox Exporter:**
```

wget https://github.com/prometheus/blackbox_exporter/releases/download/v0.25.0/blackbox_exporter-0.25.0.linux-amd64.tar.gz 
tar xvfz blackbox_exporter-0.25.0.linux-amd64.tar.gz cd blackbox_exporter-0.25.0.linux-amd64 
./blackbox_exporter & 
```
**3.Install Alertmanager:**
``` 
wget 
https://github.com/prometheus/alertmanager/releases/download/v0.27.0/ale rtmanager-0.27.0.linux-amd64.tar.gz 

tar xvfz alertmanager-0.27.0.linux-amd64.tar.gz cd alertmanager-0.27.0.linux-amd64 
./alertmanager --config.file=alertmanager.yml & 
```


## Configuration Files 

**Prometheus Configuration (prometheus.yml)**
 
Go inside the prometheus.yml file and add these configurations. 
```yaml

# my global config
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
          # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: "prometheus"

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
      - targets: ["localhost:9090"]
  - job_name: "node_exporter"

    static_configs:
      - targets: ["34.132.165.185:9100"]

# blackbox_exporter

  - job_name: 'blackbox'
    metrics_path: /probe
    params:
      module: [http_2xx]  # Look for a HTTP 200 response.
    static_configs:
      - targets:
        - http://prometheus.io    # Target to probe with http.
        - https://prometheus.io   # Target to probe with https.
        - http://34.132.165.185:8080 # Target to probe with http on port 8080 run on your applications.
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 34.123.68.53:9115  # The blackbox exporter's real hostname:port.
  - job_name: 'blackbox_exporter'  # collect blackbox exporter's operational metrics.
    static_configs:
      - targets: ['34.123.68.53:9115'] # give on block box exporter ip
```

* changing the yaml file 

```
    pgrep prometheus
    kill <id>
```

* prometheus datasources add this on grafana

* in grafana urls: 
    --> connections-> datasources-> add datasources--> prometheus--> ipurl
           save
		   
	  clik on dashboard 
	  search on dashboard--> url:dashboard blackbox grafana


## system level monataring in jenkins server monatring
 
 * install plugin prometheus metrics
 
 * in install on node_exporter on jenkins server
 
 --> ./ noed_exporter &


   http://localhost:9100
   
   monataring -->

   vi prometheus

in url:  
   node_exporter dashboard grafana