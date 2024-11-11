#!/usr/bin/env python3

import requests
import json
import sys
import os
import socket

# --- settings ---

verbose=True                                # talk too, or just action
tier=2                                      # set this to the tier of servers you want to restrict the search to
test=5                                      # the x lowest-load servers will be tested for average round-trip time
threshold=50                                # only reconsider the connection if current-peer load is above this number
country = str(sys.argv[1])                  # enter the country abbreviation ProtonVPN uses, set here to first argument 
state = str(sys.argv[2])                    # enter the state abbreviation ProtonVPN uses, set here to (mandatory) second argument (can be set to "")
peer_name='ProtonVPN-'+country.upper()      # enter the name of your peer as entered in RouterOS, set here to be 'ProtonVPN-XX' where XX is the country code
ssh_host='192.168.1.1'                      # the IP address of your Mikrotik
ssh_port=22                                 # the SSH port of your Mikrotik
ssh_identity='-i ~/.ssh/id_rsa'             # use this if you need to reference a specific ssh key 
ssh_user='rob'                              # the username with which to access your Mikrotik

# ----------------

def runOnRouter(command):
    ssh_command = 'ssh -l '+ssh_user+' '+ssh_identity+' -p '+str(ssh_port)+' '+ssh_host+' "'+command+'"'
    os.system(ssh_command)

def getFromRouter(command,filter):
    ssh_command = 'ssh -l '+ssh_user+' '+ssh_identity+' -p '+str(ssh_port)+' '+ssh_host+' "'+command+'" | grep '+filter
    stream = os.popen(ssh_command)
    return stream.read()

router_raw=getFromRouter('/ip ipsec peer print where name='+peer_name,'.protonvpn.com')
current_peer=router_raw[router_raw.find('address=')+len('address='):router_raw.rfind(' profile')]

if verbose: print('Downloading server metrics')

response = requests.get('https://api.protonvpn.ch/vpn/logicals').text
json = json.loads(response)

hostnames_matched = [] 
loads_matched = [] 

hostnames_valid = []
loads_valid = [] 

hostnames_best = [] 
loads_best = [] 
rtts_best = [] 

if verbose: print('-',len(json['LogicalServers']),'total servers')

for server in json['LogicalServers']:

    if server['ExitCountry'] == country and server['Domain'].startswith(country.lower()+'-'+state.lower()) and server['Tier'] == tier:
        hostnames_matched.append(server['Domain'])
        loads_matched.append(server['Load'])

if verbose: print('-',len(hostnames_matched),'match criteria')

if verbose: print('Curent',country.upper(),'peer:')
if verbose: print('- Set to',current_peer)

if current_peer in hostnames_matched: 

    if verbose: print('- Found in list')

    for x in range(len(hostnames_matched)): 

        if hostnames_matched[x] == current_peer: 
            if loads_matched[x] > threshold: 
                if verbose: print('- Current load at',str(loads_matched[x])+'%','is above review threshold',str(threshold)+'%')
                optimize=True
            if loads_matched[x] < threshold: 
                if verbose: print('- Load at',str(loads_matched[x])+'%','is below review threshold',str(threshold)+'%')
                optimize=False

else: 
    if verbose: print('- Not found in list')
    optimize=True

if optimize: 
    if verbose: print('Finding better server')

    for y in range(len(hostnames_matched)): 

        try: 
            ip = socket.gethostbyname(hostnames_matched[y])
            hostnames_valid.append(hostnames_matched[y])
            loads_valid.append(loads_matched[y])
        except: 
            pass

    if test > len(hostnames_valid): 
        test = len(hostnames_valid)

    if verbose: print('-',len(hostnames_valid),'are valid hostnames')
    if verbose: print('-',test,'lowest load servers being tested')

    for x in range(test):

        mindex = loads_valid.index(min(loads_valid))

        try: 
            rtt = os.popen("ping -c 10 "+hostnames_valid[mindex]+" | tail -n 1 | awk -F'/' '{ print $5 }'").read().rstrip() 
            hostnames_best.append(hostnames_valid[mindex])
            loads_best.append(loads_valid[mindex])
            rtts_best.append(rtt)
            if verbose: print('  '+str(x+1)+': '+hostnames_valid[mindex]+', load='+str(loads_valid[mindex])+'%, rtt='+str(rtt))
        except: 
            pass

        del hostnames_valid[mindex]
        del loads_valid[mindex]

    best_server = hostnames_best[rtts_best.index(min(rtts_best))]
    
    if best_server == current_peer: 
        if verbose: print('Current peer has the best performance')
    else: 
        if verbose: print('Found a better server')
        if verbose: print('- Disabling',current_peer)
        runOnRouter('/ip ipsec peer disable '+peer_name)
        if verbose: print('- Changing',country,'peer to',best_server)
        runOnRouter('/ip ipsec peer set address='+best_server+' '+peer_name)
        if verbose: print('- Enabling',best_server)
        runOnRouter('/ip ipsec peer enable '+peer_name)

else: 
    if verbose: print('No need to find a better server')

if verbose: print('Done')
