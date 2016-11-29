if(NOT TARGET Cinder-NFD)
  get_filename_component( CINDER-NFD_PATH "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)
	get_filename_component( CINDER_PATH "${CMAKE_CURRENT_LIST_DIR}/../../../../Cinder" ABSOLUTE )
  message("CINDER PATH= ${CINDER_PATH}")
  list( APPEND CINDER-NFD_SOURCES
    ${CINDER-NFD_PATH}/src/nativefiledialog/src/nfd_common.c
    ${CINDER-NFD_PATH}/src/nativefiledialog/src/nfd_gtk.c
    )
  find_package(PkgConfig REQUIRED)
  pkg_check_modules(GTK3 REQUIRED gtk+-3.0)
  include_directories("${CINDER-NFD_PATH}/src/nativefiledialog/src/include")
  include_directories(${GTK3_INCLUDE_DIRS})
  link_directories(${GTK3_LIBRARY_DIRS})
  add_definitions(${GTK3_CFLAGS_OTHER})
  add_library(Cinder-NFD ${CINDER-NFD_SOURCES})
  target_include_directories( Cinder-NFD PUBLIC
    "${CINDER-NFD_PATH}/src/include")
	target_include_directories( Cinder-NFD SYSTEM BEFORE PUBLIC "${CINDER_PATH}/include" )
	if( NOT TARGET cinder )
		include( "${CINDER_PATH}/proj/cmake/configure.cmake" )
		find_package( cinder REQUIRED PATHS
		  "${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
		  "$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}" )
	endif()
  target_link_libraries(Cinder-NFD PRIVATE cinder)
  target_link_libraries(Cinder-NFD PUBLIC ${GTK3_LIBRARIES})
endif()
