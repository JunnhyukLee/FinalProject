
package parking.car.project.term.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.inject.Inject;
import parking.car.project.term.dto.TermDTO;
import parking.car.project.term.entity.Term;
import parking.car.project.term.repository.TermRepository;

@Service
public class TermService {

    @Inject
    private TermRepository termRepository;

    @Transactional(readOnly = true)
    public List<TermDTO> termSelectAll() {
        List<Term> terms = termRepository.findAll();
        return terms.stream()
                    .map(term -> {
                        TermDTO dto = new TermDTO();
                        dto.setTerm_code(term.getTerm_code());
                        dto.setTerm_content(term.getTerm_content());
                        return dto;
                    })
                    .collect(Collectors.toList());
    }
}
