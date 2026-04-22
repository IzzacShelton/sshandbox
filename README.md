
Setup:
If needed, generate a new keypair.
```
ssh-keygen -t ed25519-sk -f ~/.ssh/id_ed25519_sk
```

copy security key's public ssh key (`~/.ssh/*_sk.pub`) as `authorized_keys` into the same directory as the `Dockerfile`
```bash
cp ~/.ssh/id_ed25519_sk.pub ../dockssh/authorized_keys
```

Running:
build & run the container
```bash
docker compose up -d --build
```

Connecting:
ssh into the docker image as ahab
```bash
ssh -i ~/.ssh/id_ed25519_sk ahab@localhost -p 2222
```

Stopping:
```
docker compose down 
```

---------------------------------------------------
