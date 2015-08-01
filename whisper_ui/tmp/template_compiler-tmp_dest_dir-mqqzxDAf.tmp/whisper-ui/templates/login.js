export default Ember.HTMLBars.template((function() {
  return {
    meta: {
      "revision": "Ember@1.13.3",
      "loc": {
        "source": null,
        "start": {
          "line": 1,
          "column": 0
        },
        "end": {
          "line": 9,
          "column": 0
        }
      },
      "moduleName": "whisper-ui/templates/login.hbs"
    },
    arity: 0,
    cachedFragment: null,
    hasRendered: false,
    buildFragment: function buildFragment(dom) {
      var el0 = dom.createDocumentFragment();
      var el1 = dom.createElement("form");
      var el2 = dom.createTextNode("\n  ");
      dom.appendChild(el1, el2);
      var el2 = dom.createElement("label");
      dom.setAttribute(el2,"for","identification");
      var el3 = dom.createTextNode("Login");
      dom.appendChild(el2, el3);
      dom.appendChild(el1, el2);
      var el2 = dom.createTextNode("\n  ");
      dom.appendChild(el1, el2);
      var el2 = dom.createComment("");
      dom.appendChild(el1, el2);
      var el2 = dom.createTextNode("\n  ");
      dom.appendChild(el1, el2);
      var el2 = dom.createElement("label");
      dom.setAttribute(el2,"for","password");
      var el3 = dom.createTextNode("Password");
      dom.appendChild(el2, el3);
      dom.appendChild(el1, el2);
      var el2 = dom.createTextNode("\n  ");
      dom.appendChild(el1, el2);
      var el2 = dom.createComment("");
      dom.appendChild(el1, el2);
      var el2 = dom.createTextNode("\n  ");
      dom.appendChild(el1, el2);
      var el2 = dom.createElement("button");
      dom.setAttribute(el2,"type","submit");
      var el3 = dom.createTextNode("Login");
      dom.appendChild(el2, el3);
      dom.appendChild(el1, el2);
      var el2 = dom.createTextNode("\n");
      dom.appendChild(el1, el2);
      dom.appendChild(el0, el1);
      var el1 = dom.createTextNode("\n");
      dom.appendChild(el0, el1);
      return el0;
    },
    buildRenderNodes: function buildRenderNodes(dom, fragment, contextualElement) {
      var element0 = dom.childAt(fragment, [0]);
      var morphs = new Array(3);
      morphs[0] = dom.createElementMorph(element0);
      morphs[1] = dom.createMorphAt(element0,3,3);
      morphs[2] = dom.createMorphAt(element0,7,7);
      return morphs;
    },
    statements: [
      ["element","action",["authenticate"],["on","submit"],["loc",[null,[2,6],[2,43]]]],
      ["inline","input",[],["id","identification","placeholder","Enter Login","value",["subexpr","@mut",[["get","identification",["loc",[null,[4,62],[4,76]]]]],[],[]]],["loc",[null,[4,2],[4,78]]]],
      ["inline","input",[],["id","password","placeholder","Enter Password","type","password","value",["subexpr","@mut",[["get","password",["loc",[null,[6,75],[6,83]]]]],[],[]]],["loc",[null,[6,2],[6,85]]]]
    ],
    locals: [],
    templates: []
  };
}()));