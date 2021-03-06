#define SWIGPY_UNARYFUNC_CLOSURE(wrapper)	\
SWIGINTERN PyObject *				\
wrapper##_closure(PyObject *a) {		\
  return wrapper(a, NULL);			\
}

#define SWIGPY_DESTRUCTOR_CLOSURE(wrapper)	\
SWIGINTERN void					\
wrapper##_closure(PyObject *a) {		\
    SwigPyObject *sobj;				\
    sobj = (SwigPyObject *)a;			\
    Py_XDECREF(sobj->dict);	                \
    if (sobj->own) {				\
	PyObject *o = wrapper(a, NULL);		\
	Py_XDECREF(o);				\
    }						\
    if (PyType_IS_GC(a->ob_type)) {		\
	PyObject_GC_Del(a);			\
    } else {					\
	PyObject_Del(a);			\
    }						\
}

#define SWIGPY_INQUIRY_CLOSURE(wrapper)				\
SWIGINTERN int							\
wrapper##_closure(PyObject *a) {				\
    PyObject *pyresult;						\
    int result;							\
    pyresult = wrapper(a, NULL);				\
    result = pyresult && PyObject_IsTrue(pyresult) ? 1 : 0;	\
    Py_XDECREF(pyresult);					\
    return result;						\
}

#define SWIGPY_BINARYFUNC_CLOSURE(wrapper)	\
SWIGINTERN PyObject *				\
wrapper##_closure(PyObject *a, PyObject *b) {	\
    PyObject *tuple, *result;			\
    tuple = PyTuple_New(1);			\
    assert(tuple);				\
    PyTuple_SET_ITEM(tuple, 0, b);		\
    Py_XINCREF(b);				\
    result = wrapper(a, tuple);			\
    Py_DECREF(tuple);				\
    return result;				\
}

typedef ternaryfunc ternarycallfunc;

#define SWIGPY_TERNARYFUNC_CLOSURE(wrapper)			\
SWIGINTERN PyObject *						\
wrapper##_closure(PyObject *a, PyObject *b, PyObject *c) {	\
    PyObject *tuple, *result;					\
    tuple = PyTuple_New(2);					\
    assert(tuple);						\
    PyTuple_SET_ITEM(tuple, 0, b);				\
    PyTuple_SET_ITEM(tuple, 1, c);				\
    Py_XINCREF(b);						\
    Py_XINCREF(c);						\
    result = wrapper(a, tuple);					\
    Py_DECREF(tuple);						\
    return result;						\
}

#define SWIGPY_TERNARYCALLFUNC_CLOSURE(wrapper)			\
SWIGINTERN PyObject *						\
wrapper##_closure(PyObject *callable_object, PyObject *args, PyObject *) {	\
    return wrapper(callable_object, args);			\
}

#define SWIGPY_LENFUNC_CLOSURE(wrapper)			\
SWIGINTERN Py_ssize_t					\
wrapper##_closure(PyObject *a) {			\
    PyObject *resultobj;				\
    Py_ssize_t result;					\
    resultobj = wrapper(a, NULL);			\
    result = PyNumber_AsSsize_t(resultobj, NULL);	\
    Py_DECREF(resultobj);				\
    return result;					\
}

#define SWIGPY_SSIZESSIZEARGFUNC_CLOSURE(wrapper)		\
SWIGINTERN PyObject *						\
wrapper##_closure(PyObject *a, Py_ssize_t b, Py_ssize_t c) {	\
    PyObject *tuple, *result;					\
    tuple = PyTuple_New(2);					\
    assert(tuple);						\
    PyTuple_SET_ITEM(tuple, 0, _PyLong_FromSsize_t(b));		\
    PyTuple_SET_ITEM(tuple, 1, _PyLong_FromSsize_t(c));		\
    result = wrapper(a, tuple);					\
    Py_DECREF(tuple);						\
    return result;						\
}

#define SWIGPY_SSIZESSIZEOBJARGPROC_CLOSURE(wrapper)			\
SWIGINTERN int								\
wrapper##_closure(PyObject *a, Py_ssize_t b, Py_ssize_t c, PyObject *d) { \
    PyObject *tuple, *resultobj;					\
    int result;								\
    tuple = PyTuple_New(d ? 3 : 2);					\
    assert(tuple);							\
    PyTuple_SET_ITEM(tuple, 0, _PyLong_FromSsize_t(b));			\
    PyTuple_SET_ITEM(tuple, 1, _PyLong_FromSsize_t(c));			\
    if (d) {								\
        PyTuple_SET_ITEM(tuple, 2, d);					\
        Py_INCREF(d);							\
    }									\
    resultobj = wrapper(a, tuple);					\
    result = resultobj ? 0 : -1;					\
    Py_DECREF(tuple);							\
    Py_XDECREF(resultobj);						\
    return result;							\
}

#define SWIGPY_SSIZEARGFUNC_CLOSURE(wrapper)		\
SWIGINTERN PyObject *					\
wrapper##_closure(PyObject *a, Py_ssize_t b) {		\
    PyObject *tuple, *result;				\
    tuple = PyTuple_New(1);				\
    assert(tuple);					\
    PyTuple_SET_ITEM(tuple, 0, _PyLong_FromSsize_t(b));	\
    result = wrapper(a, tuple);				\
    Py_DECREF(tuple);					\
    return result;					\
}

#define SWIGPY_FUNPACK_SSIZEARGFUNC_CLOSURE(wrapper)		\
SWIGINTERN PyObject *					\
wrapper##_closure(PyObject *a, Py_ssize_t b) {		\
    PyObject *arg, *result;				\
    arg = _PyLong_FromSsize_t(b);			\
    result = wrapper(a, arg);				\
    Py_DECREF(arg);					\
    return result;					\
}

#define SWIGPY_SSIZEOBJARGPROC_CLOSURE(wrapper)			\
SWIGINTERN int							\
wrapper##_closure(PyObject *a, Py_ssize_t b, PyObject *c) {	\
    PyObject *tuple, *resultobj;				\
    int result;							\
    tuple = PyTuple_New(2);					\
    assert(tuple);						\
    PyTuple_SET_ITEM(tuple, 0, _PyLong_FromSsize_t(b));		\
    PyTuple_SET_ITEM(tuple, 1, c);				\
    Py_XINCREF(c);						\
    resultobj = wrapper(a, tuple);				\
    result = resultobj ? 0 : -1;				\
    Py_XDECREF(resultobj);					\
    Py_DECREF(tuple);						\
    return result;						\
}

#define SWIGPY_OBJOBJARGPROC_CLOSURE(wrapper)			\
SWIGINTERN int							\
wrapper##_closure(PyObject *a, PyObject *b, PyObject *c) {	\
    PyObject *tuple, *resultobj;				\
    int result;							\
    tuple = PyTuple_New(c ? 2 : 1);				\
    assert(tuple);						\
    PyTuple_SET_ITEM(tuple, 0, b);				\
    Py_XINCREF(b);						\
    if (c) {							\
        PyTuple_SET_ITEM(tuple, 1, c);				\
        Py_XINCREF(c);						\
    }								\
    resultobj = wrapper(a, tuple);				\
    result = resultobj ? 0 : -1;				\
    Py_XDECREF(resultobj);					\
    Py_DECREF(tuple);						\
    return result;						\
}

#define SWIGPY_REPRFUNC_CLOSURE(wrapper)	\
SWIGINTERN PyObject *				\
wrapper##_closure(PyObject *a) {		\
    return wrapper(a, NULL);			\
}

#define SWIGPY_HASHFUNC_CLOSURE(wrapper)	\
SWIGINTERN long					\
wrapper##_closure(PyObject *a) {		\
    PyObject *pyresult;				\
    long result;				\
    pyresult = wrapper(a, NULL);		\
    if (!pyresult || !PyLong_Check(pyresult))	\
	return -1;				\
    result = PyLong_AsLong(pyresult);		\
    Py_DECREF(pyresult);			\
    return result;				\
}

#define SWIGPY_ITERNEXT_CLOSURE(wrapper)	\
SWIGINTERN PyObject *				\
wrapper##_closure(PyObject *a) {		\
    PyObject *result;				\
    result = wrapper(a, NULL);			\
    if (result && result == Py_None) {		\
	Py_DECREF(result);			\
	result = NULL;				\
    }						\
    return result;				\
}

#ifdef __cplusplus
extern "C" {
#endif

SWIGINTERN int
SwigPyBuiltin_BadInit(PyObject *self, PyObject *SWIGUNUSEDPARM(args), PyObject *SWIGUNUSEDPARM(kwds)) {
  PyErr_Format(PyExc_TypeError, "Cannot create new instances of type '%.300s'", self->ob_type->tp_name);
  return -1;
}

SWIGINTERN void
SwigPyBuiltin_BadDealloc(PyObject *pyobj) {
  SwigPyObject *sobj;
  sobj = (SwigPyObject *)pyobj;
  if (sobj->own) {
    PyErr_Format(PyExc_TypeError, "Swig detected a memory leak in type '%.300s': no callable destructor found.", pyobj->ob_type->tp_name);
  }
}

typedef struct {
  PyCFunction get;
  PyCFunction set;
} SwigPyGetSet;

SWIGINTERN PyObject *
SwigPyBuiltin_GetterClosure (PyObject *obj, void *closure) {
  SwigPyGetSet *getset;
  PyObject *tuple, *result;
  if (!closure)
    return SWIG_Py_Void();
  getset = (SwigPyGetSet *)closure;
  if (!getset->get)
    return SWIG_Py_Void();
  tuple = PyTuple_New(0);
  assert(tuple);
  result = (*getset->get)(obj, tuple);
  Py_DECREF(tuple);
  return result;
}

SWIGINTERN PyObject *
SwigPyBuiltin_FunpackGetterClosure (PyObject *obj, void *closure) {
  SwigPyGetSet *getset;
  PyObject *result;
  if (!closure)
    return SWIG_Py_Void();
  getset = (SwigPyGetSet *)closure;
  if (!getset->get)
    return SWIG_Py_Void();
  result = (*getset->get)(obj, NULL);
  return result;
}

SWIGINTERN int
SwigPyBuiltin_SetterClosure (PyObject *obj, PyObject *val, void *closure) {
  SwigPyGetSet *getset;
  PyObject *tuple, *result;
  if (!closure) {
    PyErr_Format(PyExc_TypeError, "Missing getset closure");
    return -1;
  }
  getset = (SwigPyGetSet *)closure;
  if (!getset->set) {
    PyErr_Format(PyExc_TypeError, "Illegal member variable assignment in type '%.300s'", obj->ob_type->tp_name);
    return -1;
  }
  tuple = PyTuple_New(1);
  assert(tuple);
  PyTuple_SET_ITEM(tuple, 0, val);
  Py_XINCREF(val);
  result = (*getset->set)(obj, tuple);
  Py_DECREF(tuple);
  Py_XDECREF(result);
  return result ? 0 : -1;
}

SWIGINTERN int
SwigPyBuiltin_FunpackSetterClosure (PyObject *obj, PyObject *val, void *closure) {
  SwigPyGetSet *getset;
  PyObject *result;
  if (!closure) {
    PyErr_Format(PyExc_TypeError, "Missing getset closure");
    return -1;
  }
  getset = (SwigPyGetSet *)closure;
  if (!getset->set) {
    PyErr_Format(PyExc_TypeError, "Illegal member variable assignment in type '%.300s'", obj->ob_type->tp_name);
    return -1;
  }
  result = (*getset->set)(obj, val);
  Py_XDECREF(result);
  return result ? 0 : -1;
}

SWIGINTERN void
SwigPyStaticVar_dealloc(PyDescrObject *descr) {
  _PyObject_GC_UNTRACK(descr);
  Py_XDECREF(PyDescr_TYPE(descr));
  Py_XDECREF(PyDescr_NAME(descr));
  PyObject_GC_Del(descr);
}

SWIGINTERN PyObject *
SwigPyStaticVar_repr(PyGetSetDescrObject *descr) {
#if PY_VERSION_HEX >= 0x03000000

  return PyUnicode_FromFormat("<class attribute '%S' of type '%s'>", PyDescr_NAME(descr), PyDescr_TYPE(descr)->tp_name);
#else
  return PyString_FromFormat("<class attribute '%s' of type '%s'>", PyString_AsString(PyDescr_NAME(descr)), PyDescr_TYPE(descr)->tp_name);
#endif
}

SWIGINTERN int
SwigPyStaticVar_traverse(PyObject *self, visitproc visit, void *arg) {
  PyDescrObject *descr;
  descr = (PyDescrObject *)self;
  Py_VISIT((PyObject*) PyDescr_TYPE(descr));
  return 0;
}

SWIGINTERN PyObject *
SwigPyStaticVar_get(PyGetSetDescrObject *descr, PyObject *obj, PyObject *SWIGUNUSEDPARM(type)) {
  if (descr->d_getset->get != NULL)
    return descr->d_getset->get(obj, descr->d_getset->closure);
#if PY_VERSION_HEX >= 0x03000000
  PyErr_Format(PyExc_AttributeError, "attribute '%.300S' of '%.100s' objects is not readable", PyDescr_NAME(descr), PyDescr_TYPE(descr)->tp_name);
#else
  PyErr_Format(PyExc_AttributeError, "attribute '%.300s' of '%.100s' objects is not readable", PyString_AsString(PyDescr_NAME(descr)), PyDescr_TYPE(descr)->tp_name);
#endif
  return NULL;
}

SWIGINTERN int
SwigPyStaticVar_set(PyGetSetDescrObject *descr, PyObject *obj, PyObject *value) {
  if (descr->d_getset->set != NULL)
    return descr->d_getset->set(obj, value, descr->d_getset->closure);
#if PY_VERSION_HEX >= 0x03000000
  PyErr_Format(PyExc_AttributeError, "attribute '%.300S' of '%.100s' objects is not writable", PyDescr_NAME(descr), PyDescr_TYPE(descr)->tp_name);
#else
  PyErr_Format(PyExc_AttributeError, "attribute '%.300s' of '%.100s' objects is not writable", PyString_AsString(PyDescr_NAME(descr)), PyDescr_TYPE(descr)->tp_name);
#endif
  return -1;
}

SWIGINTERN int
SwigPyObjectType_setattro(PyTypeObject *type, PyObject *name, PyObject *value) {
  PyObject *attribute;
  descrsetfunc local_set;
  attribute = _PyType_Lookup(type, name);
  if (attribute != NULL) {
    /* Implement descriptor functionality, if any */
    local_set = attribute->ob_type->tp_descr_set;
    if (local_set != NULL)
      return local_set(attribute, (PyObject *)type, value);
#if PY_VERSION_HEX >= 0x03000000
    PyErr_Format(PyExc_AttributeError, "cannot modify read-only attribute '%.50s.%.400S'", type->tp_name, name);
#else 
    PyErr_Format(PyExc_AttributeError, "cannot modify read-only attribute '%.50s.%.400s'", type->tp_name, PyString_AS_STRING(name));
#endif
  } else {
#if PY_VERSION_HEX >= 0x03000000
    PyErr_Format(PyExc_AttributeError, "type '%.50s' has no attribute '%.400S'", type->tp_name, name);
#else
    PyErr_Format(PyExc_AttributeError, "type '%.50s' has no attribute '%.400s'", type->tp_name, PyString_AS_STRING(name));
#endif
  }

  return -1;
}

SWIGINTERN PyTypeObject*
SwigPyStaticVar_Type(void) {
  static PyTypeObject staticvar_type;
  static int type_init = 0;
  if (!type_init) {
    const PyTypeObject tmp = {
      /* PyObject header changed in Python 3 */
#if PY_VERSION_HEX >= 0x03000000
      PyVarObject_HEAD_INIT(&PyType_Type, 0)
#else
      PyObject_HEAD_INIT(&PyType_Type)
      0,
#endif
      "swig_static_var_getset_descriptor",
      sizeof(PyGetSetDescrObject),
      0,
      (destructor)SwigPyStaticVar_dealloc,      /* tp_dealloc */
      0,                                        /* tp_print */
      0,                                        /* tp_getattr */
      0,                                        /* tp_setattr */
      0,                                        /* tp_compare */
      (reprfunc)SwigPyStaticVar_repr,           /* tp_repr */
      0,                                        /* tp_as_number */
      0,                                        /* tp_as_sequence */
      0,                                        /* tp_as_mapping */
      0,                                        /* tp_hash */
      0,                                        /* tp_call */
      0,                                        /* tp_str */
      PyObject_GenericGetAttr,                  /* tp_getattro */
      0,                                        /* tp_setattro */
      0,                                        /* tp_as_buffer */
      Py_TPFLAGS_DEFAULT|Py_TPFLAGS_HAVE_GC|Py_TPFLAGS_HAVE_CLASS, /* tp_flags */
      0,                                        /* tp_doc */
      SwigPyStaticVar_traverse,                 /* tp_traverse */
      0,                                        /* tp_clear */
      0,                                        /* tp_richcompare */
      0,                                        /* tp_weaklistoffset */
      0,                                        /* tp_iter */
      0,                                        /* tp_iternext */
      0,                                        /* tp_methods */
      0,                                        /* tp_members */
      0,                                        /* tp_getset */
      0,                                        /* tp_base */
      0,                                        /* tp_dict */
      (descrgetfunc)SwigPyStaticVar_get,        /* tp_descr_get */
      (descrsetfunc)SwigPyStaticVar_set,        /* tp_descr_set */
      0,                                        /* tp_dictoffset */
      0,                                        /* tp_init */
      0,                                        /* tp_alloc */
      0,                                        /* tp_new */
      0,                                        /* tp_free */
      0,                                        /* tp_is_gc */
      0,                                        /* tp_bases */
      0,                                        /* tp_mro */
      0,                                        /* tp_cache */
      0,                                        /* tp_subclasses */
      0,                                        /* tp_weaklist */
#if PY_VERSION_HEX >= 0x02030000
      0,                                        /* tp_del */
#endif
#if PY_VERSION_HEX >= 0x02060000
      0,                                        /* tp_version */
#endif
#ifdef COUNT_ALLOCS
      0,0,0,0                                   /* tp_alloc -> tp_next */
#endif
    };
    staticvar_type = tmp;
    type_init = 1;
#if PY_VERSION_HEX < 0x02020000
    staticvar_type.ob_type = &PyType_Type;
#else
    if (PyType_Ready(&staticvar_type) < 0)
      return NULL;
#endif
  }
  return &staticvar_type;
}

SWIGINTERN PyGetSetDescrObject *
SwigPyStaticVar_new_getset(PyTypeObject *type, PyGetSetDef *getset) {

  PyGetSetDescrObject *descr;
  descr = (PyGetSetDescrObject *)PyType_GenericAlloc(SwigPyStaticVar_Type(), 0);
  assert(descr);
  Py_XINCREF(type);
  PyDescr_TYPE(descr) = type;
  PyDescr_NAME(descr) = PyString_InternFromString(getset->name);
  descr->d_getset = getset;
  if (PyDescr_NAME(descr) == NULL) {
    Py_DECREF(descr);
    descr = NULL;
  }
  return descr;
}

SWIGINTERN void
SwigPyBuiltin_InitBases (PyTypeObject *type, PyTypeObject **bases) {
  int base_count = 0;
  PyTypeObject **b;
  PyObject *tuple;
  int i;

  if (!bases[0]) {
    bases[0] = SwigPyObject_type();
    bases[1] = NULL;
  }
  type->tp_base = bases[0];
  Py_INCREF((PyObject *)bases[0]);
  for (b = bases; *b != NULL; ++b)
    ++base_count;
  tuple = PyTuple_New(base_count);
  for (i = 0; i < base_count; ++i) {
    PyTuple_SET_ITEM(tuple, i, (PyObject *)bases[i]);
    Py_INCREF((PyObject *)bases[i]);
  }
  type->tp_bases = tuple;
}

SWIGINTERN PyObject *
SwigPyBuiltin_ThisClosure (PyObject *self, void *SWIGUNUSEDPARM(closure)) {
  PyObject *result;
  result = (PyObject *)SWIG_Python_GetSwigThis(self);
  Py_XINCREF(result);
  return result;
}

SWIGINTERN void
SwigPyBuiltin_SetMetaType (PyTypeObject *type, PyTypeObject *metatype)
{
#if PY_VERSION_HEX >= 0x03000000
    type->ob_base.ob_base.ob_type = metatype;
#else
    type->ob_type = metatype;
#endif
}

#ifdef __cplusplus
}
#endif

