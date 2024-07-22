using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Data;

namespace backend.Repositories
{
    public class CitizensRepository
    {
        private readonly ApplicationDbContext _context;

        public CitizensRepository(ApplicationDbContext context)
        {
            _context = context;
        }
    }
}