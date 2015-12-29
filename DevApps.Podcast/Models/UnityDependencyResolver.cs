using Microsoft.Practices.Unity;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace DevApps.Podcast.Models
{
    /// <summary>
    /// See http://www.asp.net/web-api/overview/advanced/dependency-injection
    /// </summary>
    public class UnityDependencyResolver : IDependencyResolver
    {
        private IUnityContainer container;
        private IDependencyResolver resolver;

        /// <summary />
        public UnityDependencyResolver(IUnityContainer container) : this(container, new UnityResolver(container))
        { }

        /// <summary />
        public UnityDependencyResolver(IUnityContainer container, IDependencyResolver resolver)
        {
            this.container = container;
            this.resolver = resolver;
        }

        /// <summary />
        public object GetService(Type serviceType)
        {
            try
            {
                return this.container.Resolve(serviceType);
            }
            catch
            {
                return this.resolver.GetService(serviceType);
            }
        }

        /// <summary />
        public IEnumerable<object> GetServices(Type serviceType)
        {
            try
            {
                return this.container.ResolveAll(serviceType);
            }
            catch
            {
                return this.resolver.GetServices(serviceType);
            }
        }
    }
}
