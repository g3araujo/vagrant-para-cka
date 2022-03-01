# Meu roteiro

Objetivo: criar ambiente de lab de baixo custo para a certificação CKA.

----

## Preparo:

Para a instalação do Kubernetes, é necessário ter 03 máquinas/vm/instâncias com o setup mínimo abaixo:
- Debian
- Ubuntu
- Centos
- Red Hat
- Fedora
- SuSe

| CPU  |  Memoria  |
| ---- | --------- |
|  2   |   2048 MB |

---

* Instalar o VirtualBox

```
sudo apt install virtualbox -y
```

---
* Instalar o vagrant

```
curl -O https://releases.hashicorp.com/vagrant/2.2.18/vagrant_2.2.18_x86_64.deb 

sudo apt install ./vagrant_2.2.18_x86_64.deb

vagrant --version
```

---

## ...:

...

```
vagrant up
```

Vai demorar um pouco, pois são 3 maquinas.

Caso queira recuperar o comando para adicionar nós:
```
sudo kubeadm token create --print-join-command
```



Para brincar de criação de cluster: https://labs.play-with-k8s.com/


  Links Importantes
Tipos de topologias de K8s multi-master: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/ha-topology/

Instalação kubeadm, kubelet e kubectl: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

Instalação Kubernetes multi-master: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/

HAproxy: https://www.haproxy.org/