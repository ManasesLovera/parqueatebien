using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Data;

namespace backend.Repositories
{
    public class ReportsRepository
    {
        private readonly ApplicationDbContext _context;

        public ReportsRepository(ApplicationDbContext context)
        {
            _context = context;
        }
    }
}