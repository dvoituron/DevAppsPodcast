using System;
using System.Web.Mvc;
using System.Xml.Serialization;

namespace DevApps.Podcast.Controllers
{
    public class XmlResult : ActionResult
    {
        private object _objectToSerialize;
        private XmlSerializerNamespaces _namespaces;

        public XmlResult(object objectToSerialize, XmlSerializerNamespaces namespaces)
        {
            _objectToSerialize = objectToSerialize;
            _namespaces = namespaces;
        }
        public XmlResult(object objectToSerialize) : this(objectToSerialize, null)
        {

        }

        public override void ExecuteResult(ControllerContext context)
        {
            if (_objectToSerialize != null)
            {
                var xs = new XmlSerializer(_objectToSerialize.GetType());
                context.HttpContext.Response.ContentType = "text/xml";
                xs.Serialize(context.HttpContext.Response.Output, _objectToSerialize, _namespaces);
            }
        }
    }
}
