set(SUPERLU_DIST_SRC_DIR "${CMAKE_CURRENT_LIST_DIR}/SRC")
find_package(MPI)
include_directories(${SUPERLU_DIST_SRC_DIR} ${MPI_C_INCLUDE_DIRS})

# auxillary routines
add_library(SUPERLU_DIST_ALLAUX OBJECT
    ${SUPERLU_DIST_SRC_DIR}/sp_ienv.c 
    ${SUPERLU_DIST_SRC_DIR}/etree.c 
    ${SUPERLU_DIST_SRC_DIR}/sp_colorder.c
    ${SUPERLU_DIST_SRC_DIR}/get_perm_c.c
    ${SUPERLU_DIST_SRC_DIR}/mmd.c
    ${SUPERLU_DIST_SRC_DIR}/comm.c 
    ${SUPERLU_DIST_SRC_DIR}/memory.c 
    ${SUPERLU_DIST_SRC_DIR}/util.c 
    ${SUPERLU_DIST_SRC_DIR}/superlu_grid.c
    ${SUPERLU_DIST_SRC_DIR}/pxerr_dist.c
    ${SUPERLU_DIST_SRC_DIR}/superlu_timer.c 
    ${SUPERLU_DIST_SRC_DIR}/GetDiagU.c
    ${SUPERLU_DIST_SRC_DIR}/symbfact.c
    ${SUPERLU_DIST_SRC_DIR}/psymbfact.c
    ${SUPERLU_DIST_SRC_DIR}/psymbfact_util.c
    ${SUPERLU_DIST_SRC_DIR}/mc64ad_dist.c
    ${SUPERLU_DIST_SRC_DIR}/static_schedule.c
    ${SUPERLU_DIST_SRC_DIR}/xerr_dist.c 
    ${SUPERLU_DIST_SRC_DIR}/smach_dist.c 
    ${SUPERLU_DIST_SRC_DIR}/dmach_dist.c
)

# serial routines
add_library(SUPERLU_DIST_DSLUSRC OBJECT
    ${SUPERLU_DIST_SRC_DIR}/dlangs_dist.c
    ${SUPERLU_DIST_SRC_DIR}/dgsequ_dist.c
    ${SUPERLU_DIST_SRC_DIR}/dlaqgs_dist.c
    ${SUPERLU_DIST_SRC_DIR}/dutil_dist.c
    ${SUPERLU_DIST_SRC_DIR}/dmemory_dist.c
    ${SUPERLU_DIST_SRC_DIR}/dmyblas2_dist.c
    ${SUPERLU_DIST_SRC_DIR}/dsp_blas2_dist.c
    ${SUPERLU_DIST_SRC_DIR}/dsp_blas3_dist.c
)

# parallel routines
add_library(SUPERLU_DIST_DPLUSRC OBJECT
    ${SUPERLU_DIST_SRC_DIR}/pdgssvx.c
    ${SUPERLU_DIST_SRC_DIR}/pdgssvx_ABglobal.c
    ${SUPERLU_DIST_SRC_DIR}/dreadhb.c
    ${SUPERLU_DIST_SRC_DIR}/dreadrb.c
    ${SUPERLU_DIST_SRC_DIR}/dreadtriple.c
    ${SUPERLU_DIST_SRC_DIR}/dreadMM.c
    ${SUPERLU_DIST_SRC_DIR}/pdgsequ.c
    ${SUPERLU_DIST_SRC_DIR}/pdlaqgs.c
    ${SUPERLU_DIST_SRC_DIR}/dldperm_dist.c
    ${SUPERLU_DIST_SRC_DIR}/pdlangs.c
    ${SUPERLU_DIST_SRC_DIR}/pdutil.c
    ${SUPERLU_DIST_SRC_DIR}/pdsymbfact_distdata.c
    ${SUPERLU_DIST_SRC_DIR}/ddistribute.c
    ${SUPERLU_DIST_SRC_DIR}/pddistribute.c
    ${SUPERLU_DIST_SRC_DIR}/pdgstrf.c
    ${SUPERLU_DIST_SRC_DIR}/pdgstrf2.c
    ${SUPERLU_DIST_SRC_DIR}/pdgstrs.c
    ${SUPERLU_DIST_SRC_DIR}/pdgstrs1.c
    ${SUPERLU_DIST_SRC_DIR}/pdgstrs_lsum.c
    ${SUPERLU_DIST_SRC_DIR}/pdgstrs_Bglobal.c
    ${SUPERLU_DIST_SRC_DIR}/pdgsrfs.c
    ${SUPERLU_DIST_SRC_DIR}/pdgsmv.c
    ${SUPERLU_DIST_SRC_DIR}/pdgsrfs_ABXglobal.c
    ${SUPERLU_DIST_SRC_DIR}/pdgsmv_AXglobal.c
)

add_library(SUPERLU_DIST)
target_link_libraries(SUPERLU_DIST
                      SUPERLU_DIST_DPLUSRC
                      SUPERLU_DIST_DSLUSRC
                      SUPERLU_DIST_ALLAUX)

export(TARGETS SUPERLU_DIST_ALLAUX
               SUPERLU_DIST_DSLUSRC
               SUPERLU_DIST_DPLUSRC
               SUPERLU_DIST
    FILE "${CMAKE_CURRENT_BINARY_DIR}/cmake/SUPERLU_DIST.cmake"
)
