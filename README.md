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

## Destruir o "Um-Anel":

Dentro do meu código o mago Gandalf será o MASTER do cluster e os hobbits serão os nodes, esperamos concluir nossa missão que é destruir o "Um Anel", digo tirar a certificação:

Meu vagrant e meus scripts crescem a medida que assito as aulas do Jeff e dessa forma meu ponto de partida diário obedece o progresso do dia anterior.

```
vagrant up gandalf
```


* Para brincar de criação de cluster: https://labs.play-with-k8s.com/