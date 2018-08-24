jupyter notebook --generate-config
sed -i ~/.jupyter/jupyter_notebook_config.py \
-e "s/#c.NotebookApp.ip = 'localhost'/c.NotebookApp.ip = '*'/"


#see also https://qiita.com/ciela/items/0e0392f600c92b93d7c6
