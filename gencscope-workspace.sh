#!/usr/bin/ksh

CSCOPE_EXE=cscope
CTAGS_EXE=ctags
GREP_EXE=grep

ROOT=/data/mqn486/tetra1
VOB_LIST="${ROOT}"

OUT_DIR=/data/mqn486/DB
FILELIST=${OUT_DIR}/tetra.files
CSCOPE_OUT=${OUT_DIR}/tetra.cscope
CSCOPE_LOG=${CSCOPE_OUT}.log
CTAGS_OUT=${OUT_DIR}/tetra.ctags
CTAGS_LOG=${CTAGS_OUT}.log

[ -d ${OUT_DIR} ] || mkdir ${OUT_DIR}

filelistcreate=y
if [ -f ${FILELIST} ]; then
    echo "${FILELIST} exists, recreate [n]"
    read filelistcreate
fi

if [ "x$filelistcreate" = "xy" ]; then
    echo "Generating filelist... "
    rm -f ${FILELIST}
                        
    for vob in ${VOB_LIST}
    do
        dirs=`\ls $vob | ${GREP_EXE} -v -x su | sort`
        for dir in $dirs
        do
            echo $vob/$dir
            find $vob/$dir -follow -name '*.c' -o -name '*.cpp' -o -name '*.h' -o -name '*.S' 2>/dev/null | sort >> ${FILELIST}
        done
    done
                                                                                        
    echo "done"
fi

rm -f ${CSCOPE_OUT}* ${CTAGS_OUT}*
cd ${OUT_DIR}

echo "Generating cscope..."
${CSCOPE_EXE} -R -b -q -i ${FILELIST} -f ${CSCOPE_OUT} > ${CSCOPE_LOG}
echo "done"
echo "Log has been written to ${CSCOPE_LOG}"

echo "Generating ctags..."
${CTAGS_EXE} -V -L ${FILELIST} -f ${CTAGS_OUT} > ${CTAGS_LOG}
echo "done"
echo "Log has been written to ${CTAGS_LOG}"


