#!/usr/bin/env bash
# TODO Need add news SOs

deps=("bc" "xdg-settings" "xrandr" "lolcat")

for i in ${deps[@]}; do
	if [[ ! $(which $i 2>/dev/null) ]]; then
		echo "Need install: $i."
		exit 1
	fi
done

usage(){
	cat <<EOF
	
  MyFetch - Show info system and logo system in ASCII
  
  -h, --help           Show help
  -v, --version        Show version
  
  * Version beta 1.0
  
EOF
}

# colors
g=$(echo -e '\e[36;1m'); y=$(echo -e '\e[32;1m'); o=$(echo -e '\e[m'); p=$(echo -e '\e[m')

display_info(){

	d_title=$USER@$HOSTNAME
	d=$(cat /proc/version | egrep -o '\([A-Z][a-z]+ ' | tr -d \()
	d_os=$(uname -o)
	d_kname=$(cat /proc/sys/kernel/ostype)
	d_kversion=$(cat /proc/sys/kernel/osrelease)
	d_uptime=$(uptime | awk '{print $3}' | tr -d ,)" min"
	d_shell=$(basename $SHELL)
	d_res=$(xrandr | sed -n '1p' | sed 's/.*current.//g;s/,.*//g;s/ //g')
	d_desk=$XDG_SESSION_DESKTOP
	d_font=$(fc-match | sed 's/\..*//g')
	d_cpu=$(cat /proc/cpuinfo | grep -o 'model name.*' | sed -n 1p | sed 's/.*:.//g;s/(.*)//g')
	d_mem=$(echo $(cat /proc/meminfo | sed -n 1p | tr -d [A-Za-z:' ']) / 1000000 | bc)" MB"
	d_memfree=$(echo "scale=2;$(cat /proc/meminfo | sed -n 2p | tr -d [A-Za-z:' '])" / 1000000 | bc)" MB"
	d_arch=$(getconf LONG_BIT)"-bit"
	d_browser=$(xdg-settings get default-web-browser | sed 's/userapp-//g;s/-.*//g;s/\..*//g')
	d_char=$(expr length "$d_title"); qtd=
	for i in $(seq 1 $d_char); do
		qtd="$qtd─"
	done
}

set_info(){
display_info
cat <<EOF


$d_title
$qtd
Distro: ${d^}
OS: $d_os
Kernel Name: $d_kname
Kernel Version: $d_kversion
Uptime: $d_uptime
Shell: ${d_shell^}
Resolution: $d_res
Desk: $d_desk
Font: $d_font
CPU: $d_cpu
RAM: $d_mem
Mem Free: $d_memfree
Architeture: $d_arch
Browser default: ${d_browser^}
EOF
}

display_info
d=${d,,}

gentoo="
           ':oxkxoc,.                 
       .lOXWMMMMMWNK0xc'.             
    .oKWMMMMMMMMMMWWNXX0Ox:.          
  .dNMMMMMMMMMMMMMNXNNXKK00Okl.       
 ,OMMMMMMMMMMMMMX0OkxxxKK00OOOOkc.    
 x0MMMMMMMMMMMKOdllddc,xK00OOOkk0Kd.  
 lxkKNWMMMMMMMMN0o;,ldOKK00OOOkkkkKWo 
  'ldxO0XNWMMMMMMMWWNXXKK00OOOkkkxxNMo
     .;ldkKWWMMMMWWNNXKK00OOOkkkxONMKd
       .dWMMMMMMWWNNXXKK00OOOkk0NMXkd.
     :0MMMMMMMMWWNNXXKK00OOO0XMWKko,  
  .dWMMMMMMMMWWNNXXXKK00O0XWMXOdc.    
 lWMMMMMMMWWWNNNXXKK00KNWWKkdl'       
lMMMMMWWWWNNNXXXKKXNWMN0xlc'          
oWMWWNNNNNXXXXNNWWXOxlc;.             
.oKWMWWWWWWWNKOxocc;..                
  ':lodoolc:::;'.                     
    .';;;;'.                          
                                      

"

ubuntu="
                                    
                          .;ccc;    
                  ......  ;ccccc,   
               ;ccccccccc. ,:c:,    
          .,c;  ;cc:;;::cc;.....    
         ,cccc:          .,:cccc,   
        :ccc:'              ':ccc:  
       ,ccc:.                .:ccc; 
 .:cc:' ,cc'                  'cccc.
 cccccc..cc.                        
 .:cc:' ,cc'                  'cccc.
       ,ccc:.                .:ccc; 
        :cccc'              ':ccc:  
         ,cccc:          .,:cccc,   
          .,c;  ;cc:;;:ccc;.....    
               ;ccccccccc. ,:c:,    
                  ......  ;ccccc,   
                          .;ccc;    
                                    
"

outra="
                                        
              .;lxOO0Oxl,.              
          'lkXN0kddddddKWNKkc.          
       'xXKo;.         kWWWWNXXd'       
     ;KNo.     dKX0o   NWWWW0 'xN0,     
   .0Nl       :WWWWW' ,WWWWWl   .dNO.   
  ;NK.        OWWWWN  dWWWWW.     'XN,  
 ,N0    'odddxNWWWWNxxXWWWWNdddo;  .XN' 
 XN.   'WWWWWWWWWWWWWWWWWWWWWWWWW:  'NK 
cWd     ONWWWWWWWWWWWWWWWWWWWWWW0.   OW;
dWc         .XWWWWX..0WWWWN.         dWo
dWc    .,;::lWWWWW0;:NWWWWK::;,      dWo
:Wd   :NWWWWWWWWWWWWWWWWWWWWWWWX.    OW;
 XN.  ;NWWWWWWWWWWWWWWWWWWWWWWWK    ,WK 
 'NK.  .',;cWWWWWO;;NWWWWK;;;,.    .XN. 
  ,NX'     :WWWWW: 'WWWWWo        ;NX'  
   .kNd.   xWWWWN. cWWWWW'      .kWk.   
     ,0Nx, NWWWW0  .x0Kk;     ;ONO'     
       .oXNWWWWWl         'ckNKo.       
          .:d0NWKkxxkkk0XN0d:.          
               .:oxxxxo:.               
                                        
"

arch="
                   .                    
                   :;                   
                  ;cc,                  
                 ,cccl'                 
                ,lllccl'                
               'lllllllo.               
              ..,lolllllo.              
             ,doc;:looollo'             
            ;dddddooooooooo,            
           :dddddoollllllllo;           
          cdoolcccccccccccccc,          
         :lccccccc,..,cccccccc;         
        :ccccccc,      ;ccccccc;        
      .:ccccccc;        cccccccc:       
     .ccccccccc.        ,ccccc:;,,      
    .cccccccccc'        ,cccccccc,.     
   'cccccc;,..           ..',:ccccc:.   
  ,cc:,.                       ..,ccc.  
 ,'.                                .,' 


"


case "$(echo $d)" in

	'gentoo') distro="$gentoo" ;;
	'ubuntu') distro="$ubuntu" ;;
	'arch') distro="$arch" ;;
	*) distro="$outra" ;;
esac

if [[ "$1" ]]; then
	while [[ "$1" ]]; do
		case "$1" in
		
			-h|--help) usage && exit 0 ;;
			-v|--version) echo Version 1.0 && exit 0 ;;
			*) echo "Invalid option" && exit 1 ;;
			
		esac
		shift
	done
else
	paste <(printf "%s" "$distro") <(printf "%s" "$(set_info)") | lolcat
fi
exit 0
