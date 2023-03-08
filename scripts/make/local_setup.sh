# Clone the necessary repositories

repos=(edgeboxctl ws api apps) 


for repo in "${repos[@]}"
do
    if [[ ! -d ./bin/$repo ]]; then
        git clone --depth 1 git@github.com:edgebox-iot/$repo.git ./bin/$repo
    fi
done
