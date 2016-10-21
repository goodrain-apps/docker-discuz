#!/bin/bash
set -e

# 数据持久化操作

persist_dirs="config data uc_server/data uc_client/data/cache"
dest_dir=/data/discuz
source_dir=/app/discuz
mkdir -p ${dest_dir}

# 在持久化存储中创建需要的目录
for d in ${persist_dirs} ; do
    if [ -d ${dest_dir}/${d} ] ; then
        rm -rf ${source_dir}/${d}
    else
        mkdir -p ${dest_dir}/${d}
        cp -r ${source_dir}/${d}/* ${dest_dir}/${d}
        rm -rf ${source_dir}/${d}
    fi
    pdir=$(dirname ${source_dir}/${d})
    ln -s ${dest_dir}/${d} ${pdir}
done

echo "discuz success"

# 设置权限
chmod -R 777 /data/

apache2-foreground
